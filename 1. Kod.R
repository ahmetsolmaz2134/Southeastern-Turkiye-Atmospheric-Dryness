library(ggplot2)

# Grafi??i de??i??kene atayal??m
p1 <- ggplot(se_turkiye_vpd_annual, aes(x = YEAR, y = mean_VPD)) +
  geom_line(color = "#e74c3c", size = 0.8) +
  geom_point(color = "#c0392b", size = 1.2) +
  geom_smooth(method = "lm", color = "#2c3e50", linetype = "dashed", se = FALSE, size = 0.9) +
  facet_wrap(~ CITY, ncol = 3) +
  labs(
    title = "Southeastern T??rkiye - Long-Term Atmospheric Dryness (VPD) Trends (1990???2025)",
    subtitle = "Vapor Pressure Deficit (VPD) Dynamics Across 9 Provinces",
    x = "Year",
    y = "Mean VPD [kPa]",
    caption = "Data Source: NASA POWER | Station Climatology"
  ) +
  theme_bw(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 13, color = "#2c3e50"),
    strip.background = element_rect(fill = "#ecf0f1"),
    strip.text = element_text(face = "bold"),
    panel.grid.minor = element_blank()
  )

# 1. Ekranda g??ster
print(p1)

# 2. ??al????ma klas??r??ne dosya olarak kaydet
ggsave("vpd_trends_all_cities.png", plot = p1, width = 11, height = 8, dpi = 300)
library(ggplot2)

p2 <- ggplot(se_turkiye_vpd_annual, aes(x = YEAR, y = reorder(CITY, mean_VPD), fill = mean_VPD)) +
  geom_tile(color = "white", size = 0.2) +
  scale_fill_viridis_c(option = "magma", name = "Mean VPD [kPa]") +
  scale_x_continuous(breaks = seq(1990, 2025, 5), expand = c(0,0)) +
  labs(
    title = "Southeastern T??rkiye - Atmospheric Dryness Intensity Matrix (1990???2025)",
    subtitle = "Spatiotemporal Variation of Vapor Pressure Deficit Across Provinces",
    x = "Year",
    y = "Province"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 13),
    axis.text.y = element_text(face = "bold"),
    panel.grid = element_blank(),
    legend.position = "bottom",
    legend.key.width = unit(1.8, "cm")
  )

# 1. Ekranda g??ster
print(p2)

# 2. ??al????ma klas??r??ne dosya olarak kaydet
ggsave("vpd_heatmap_matrix.png", plot = p2, width = 11, height = 5.5, dpi = 300)
# Gerekli paketleri yukleyelim (Yoksa install.packages(...) ile kurabilirsiniz)
library(dplyr)
library(tidyr)
library(trend)       # Pettitt testi ve Sen's Slope i??in
library(Kendall)     # Mann-Kendall testi i??in
library(ggplot2)
library(ggcorrplot)  # Korelasyon matrisi g??rselle??tirmesi i??in
# Ayl??k ortalama verinin haz??rlanmas??
se_turkiye_vpd_monthly <- se_turkiye_vpd_daily %>%
  group_by(YEAR, MONTH) %>%
  summarise(mean_VPD = mean(VPD, na.rm = TRUE), .groups = "drop") %>%
  arrange(YEAR, MONTH)

# Zaman serisi (ts) nesnesine d??n????t??rme (12 ayl??k periyot)
vpd_ts <- ts(se_turkiye_vpd_monthly$mean_VPD, start = c(1990, 1), frequency = 12)

# STL Ayr????t??rmas??
stl_decomp <- stl(vpd_ts, s.window = "periodic", t.window = 13)

# G??rselle??tirme
plot(stl_decomp, main = "Southeastern T??rkiye - Regional Monthly VPD STL Decomposition (1990???2025)")
# De??i??kenlerin matris format??na getirilmesi
clim_vars <- se_turkiye_vpd_daily %>%
  select(VPD, T2M, RH2M) %>%
  na.omit()

# 1. Pearson Korelasyon Matrisi (Lineer ??li??ki)
pearson_corr <- cor(clim_vars, method = "pearson")
print("Pearson Correlation Matrix:")
print(pearson_corr)

# 2. Spearman Korelasyon Matrisi (S??ralamal?? / Monotonik ??li??ki)
spearman_corr <- cor(clim_vars, method = "spearman")
print("Spearman Correlation Matrix:")
print(spearman_corr)

# Korelasyon Matrisi Grafi??i (Pearson)
ggcorrplot(pearson_corr, 
           method = "square", 
           type = "lower", 
           lab = TRUE, 
           lab_size = 4, 
           title = "Pearson Correlation Matrix (VPD, T2M, RH2M)",
           colors = c("#3498db", "white", "#e74c3c"))
library(ggplot2)
library(dplyr)
library(trend)
library(Kendall)

# 1. Her il i??in Mann-Kendall ve Sen's Slope istatistiklerini hesaplayal??m
mk_stats_labels <- se_turkiye_vpd_annual %>%
  group_by(CITY) %>%
  summarise(
    tau = MannKendall(mean_VPD)$tau[1],
    p_val = MannKendall(mean_VPD)$sl[1],
    slope_dec = sens.slope(mean_VPD)$estimates * 10, # 10 y??ll??k de??i??im
    max_vpd = max(mean_VPD),
    min_vpd = min(mean_VPD),
    .groups = "drop"
  ) %>%
  mutate(
    # Grafik ??zerine yaz??lacak akademik bilgi etiketi
    label_text = paste0("Kendall Tau: ", round(tau, 2), 
                        "\np-value: ", ifelse(p_val < 0.001, "< 0.001", round(p_val, 3)),
                        "\nSen's Slope: +", round(slope_dec, 3), " kPa/dec")
  )

# 2. Grafi??in Olu??turulmas??
p_mk <- ggplot(se_turkiye_vpd_annual, aes(x = YEAR, y = mean_VPD)) +
  # G??zlem ??izgisi ve noktalar??
  geom_line(color = "#2c3e50", size = 0.7) +
  geom_point(color = "#e74c3c", size = 1.4) +
  # Sen's Slope / Lineer E??ilim ??izgisi ve G??ven Aral??????
  geom_smooth(method = "lm", color = "#c0392b", linetype = "solid", size = 1, se = TRUE, alpha = 0.15) +
  # Mann-Kendall ??statistiksel Etiketleri
  geom_text(data = mk_stats_labels, 
            aes(x = 1991, y = max_vpd * 0.98, label = label_text),
            hjust = 0, vjust = 1, size = 3.1, fontface = "bold", color = "#1a252f") +
  facet_wrap(~ CITY, ncol = 3, scales = "free_y") +
  labs(
    title = "Southeastern T??rkiye - Mann-Kendall Trend & Sen's Slope Analysis (1990???2025)",
    subtitle = "Non-Parametric Statistical Trend Test (p-value, Kendall's Tau) and Decadal Slope Estimator Across 9 Provinces",
    x = "Year",
    y = "Mean Vapor Pressure Deficit (VPD) [kPa]",
    caption = "Data: NASA POWER | Method: Mann-Kendall Trend Test & Sen's Slope Estimator"
  ) +
  theme_bw(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 13, color = "#2c3e50"),
    plot.subtitle = element_text(size = 9.5, color = "#555555"),
    strip.background = element_rect(fill = "#34495e"),
    strip.text = element_text(face = "bold", color = "white"),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(color = "#ecf0f1", linetype = "dotted")
  )

# 3. Ekranda G??ster ve Kaydet
print(p_mk)
ggsave("mann_kendall_sens_slope_plot.png", plot = p_mk, width = 11, height = 8.5, dpi = 300)
library(ggplot2)
library(dplyr)
library(trend)

# 1. Her il i??in Pettitt De??i??im Noktas?? ??statistiklerini Hesaplama
pettitt_results <- se_turkiye_vpd_annual %>%
  group_by(CITY) %>%
  summarise(
    pett_k = pettitt.test(mean_VPD)$statistic,
    p_val = pettitt.test(mean_VPD)$p.value,
    change_idx = pettitt.test(mean_VPD)$estimate,
    break_year = YEAR[change_idx],
    
    # K??r??lma ??ncesi ve sonras?? VPD ortalamalar??
    mean_before = mean(mean_VPD[YEAR <= break_year]),
    mean_after = mean(mean_VPD[YEAR > break_year]),
    max_vpd = max(mean_VPD),
    .groups = "drop"
  ) %>%
  mutate(
    # Grafik ??zerine eklenecek istatistik etiketi
    label_text = paste0("Break Year: ", break_year,
                        "\nK-stat: ", pett_k,
                        "\np-value: ", ifelse(p_val < 0.001, "< 0.001", round(p_val, 3)),
                        "\n??VPD: +", round(mean_after - mean_before, 3), " kPa")
  )

# 2. Y??ll??k veriye k??r??lma ??ncesi/sonras?? d??nem ortalamalar??n?? birle??tirme
vpd_pettitt_df <- se_turkiye_vpd_annual %>%
  inner_join(pettitt_results, by = "CITY") %>%
  mutate(
    segment_mean = if_else(YEAR <= break_year, mean_before, mean_after)
  )

# 3. Pettitt De??i??im Noktas?? Paneli Grafi??i (ggplot2)
p_pettitt <- ggplot(vpd_pettitt_df, aes(x = YEAR, y = mean_VPD)) +
  # Y??ll??k VPD ??izgisi ve Noktalar??
  geom_line(color = "#7f8c8d", size = 0.6) +
  geom_point(color = "#2c3e50", size = 1.3) +
  
  # K??r??lma Y??l?? Dikey ??izgisi (K??rm??z?? Kesikli Line)
  geom_vline(aes(xintercept = break_year), color = "#e74c3c", linetype = "dashed", size = 0.9) +
  
  # K??r??lma ??ncesi ve Sonras?? D??nemsel Ortalama Basamak ??izgileri
  geom_line(aes(y = segment_mean, group = YEAR > break_year), color = "#c0392b", size = 1.1) +
  
  # Pettitt Test Sonu?? Metin Kutular??
  geom_text(data = pettitt_results,
            aes(x = 1991, y = max_vpd * 0.98, label = label_text),
            hjust = 0, vjust = 1, size = 3.0, fontface = "bold", color = "#16a085") +
  
  facet_wrap(~ CITY, ncol = 3, scales = "free_y") +
  labs(
    title = "Southeastern T??rkiye - Pettitt Change-Point Analysis (1990???2025)",
    subtitle = "Non-Parametric Abrupt Shift Detection in Atmospheric Dryness (VPD) Across 9 Provinces",
    x = "Year",
    y = "Mean Vapor Pressure Deficit (VPD) [kPa]",
    caption = "Data: NASA POWER | Method: Pettitt Test for Single Change-Point Detection"
  ) +
  theme_bw(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 13, color = "#2c3e50"),
    plot.subtitle = element_text(size = 9.5, color = "#555555"),
    strip.background = element_rect(fill = "#2c3e50"),
    strip.text = element_text(face = "bold", color = "white"),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(color = "#ecf0f1", linetype = "dotted")
  )

# 4. Ekranda G??ster ve Y??ksek ????z??n??rl??kte Kaydet
print(p_pettitt)
ggsave("pettitt_changepoint_plot.png", plot = p_pettitt, width = 11, height = 8.5, dpi = 300)
library(dplyr)
library(SPEI)
library(ggplot2)

# 1. Grafikleri s??f??rla (varsa a????k/kilitli grafik penceresini kapat??r)
graphics.off()

# Enlem koordinatlar??
city_latitudes <- c(
  "Adiyaman" = 37.76, "Batman" = 37.88, "Diyarbakir" = 37.91,
  "Gaziantep" = 37.06, "Kilis" = 36.71, "Mardin" = 37.31,
  "Sanliurfa" = 37.16, "Siirt" = 37.93, "Sirnak" = 37.51
)

# 2. Ayl??k ve Y??ll??k PET Hesab??
se_turkiye_pet_annual <- se_turkiye_vpd_daily %>%
  mutate(LAT = city_latitudes[CITY]) %>%
  group_by(CITY, YEAR, MONTH) %>%
  summarise(
    mean_T2M = mean(T2M, na.rm = TRUE),
    lat = first(LAT),
    .groups = "drop"
  ) %>%
  group_by(CITY) %>%
  mutate(
    PET_Thornthwaite = as.numeric(thornthwaite(mean_T2M, lat = first(lat)))
  ) %>%
  group_by(CITY, YEAR) %>%
  summarise(
    annual_PET = sum(PET_Thornthwaite, na.rm = TRUE),
    .groups = "drop"
  )

# 3. Grafi??in Olu??turulmas??
p_pet <- ggplot(se_turkiye_pet_annual, aes(x = YEAR, y = annual_PET)) +
  geom_line(color = "#d35400", size = 0.8) +
  geom_point(color = "#e67e22", size = 1.3) +
  geom_smooth(method = "lm", color = "#2c3e50", linetype = "dashed", size = 0.9, se = FALSE) +
  facet_wrap(~ CITY, ncol = 3, scales = "free_y") +
  labs(
    title = "Southeastern T??rkiye - Annual Potential Evapotranspiration (PET) Trends (1990???2025)",
    subtitle = "Thornthwaite Atmospheric Evaporative Demand [mm/year]",
    x = "Year",
    y = "Annual PET [mm/year]"
  ) +
  theme_bw(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 12, color = "#2c3e50"),
    strip.background = element_rect(fill = "#d35400"),
    strip.text = element_text(face = "bold", color = "white"),
    panel.grid.minor = element_blank()
  )

# 4. Ekrana zorunlu ??izdirme
dev.new() # Yeni grafik penceresi a??ar
print(p_pet)

# 5. Disk ??zerine kaydetme
ggsave("pet_trends_all_cities.png", plot = p_pet, width = 11, height = 8.5, dpi = 300)
