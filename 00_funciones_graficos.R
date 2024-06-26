
plt0 = list("#41B5E9", "#FA8832", "#34393C", "#E46151")
plt1 = list("#e41a1c", "#377eb8", "#4daf4a", "#984ea3", "#ff7f00", "#ffff33", "#a65628")
plt2 = list("#1b7837", "#d73027", "#34393C", "#af8dc3")
plt3 = list("#4a1486", "#5ab4ac", "#d8b365", "#999999")

hc_theme_elementary2 = function (plt = plt0, ...) 
{
  theme <- list(colors = plt,
                chart = list(style = list(color = "#333", fontFamily = "Open Sans")), 
                title = list(style = list(fontFamily = "Raleway", fontWeight = "100")),
                subtitle = list(style = list(fontFamily = "Raleway", fontWeight = "100")), 
                legend = list(align = "right", verticalAlign = "bottom"), 
                xAxis = list(gridLineWidth = 1, gridLineColor = "#F3F3F3",
                             lineColor = "#F3F3F3", minorGridLineColor = "#F3F3F3", 
                             tickColor = "#F3F3F3", tickWidth = 1), 
                yAxis = list(gridLineColor = "#F3F3F3", lineColor = "#F3F3F3",
                             minorGridLineColor = "#F3F3F3", tickColor = "#F3F3F3",
                             tickWidth = 1))
  
  theme <- structure(theme, class = "hc_theme")
  if (length(list(...)) > 0) {
    theme <- hc_theme_merge(theme, hc_theme(...))
  }
  theme
}
