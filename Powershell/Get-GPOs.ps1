# GPO Exporter: This will generate an HTML file for each GPO with all their properties.

# Change the following Path:
$REPORT_PATH = 'C:\\<PATH>'

# Collect Info
$AllGPOs = Get-GPO -All

# Process Info
foreach ($GPO in $AllGPOs) {
$GPOGUID = $GPO.Id
$ReportPath = $REPORT_PATH + $GPO.DisplayName + ".html"
Get-GPOReport -Guid $GPOGUID -ReportType html -Path $ReportPath
}
