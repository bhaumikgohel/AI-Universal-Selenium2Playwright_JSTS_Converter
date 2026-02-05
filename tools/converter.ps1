param (
    [Parameter(Mandatory=$true)]
    [string]$SourceCode,
    [string]$Language = "typescript"
)

$Model = "llama3.2:latest"
$Endpoint = "http://localhost:11434/api/chat"

$SystemPrompt = @"
You are an expert test automation engineer specializing in Selenium Java and Playwright.
Your task is to convert Selenium Java (TestNG) code into modern, readable Playwright $Language code.

### Rules:
1. Map TestNG annotations (@Test, @BeforeMethod, etc.) to Playwright hooks.
2. Use modern Playwright locators (locator, getByRole, getById).
3. Ensure all actions are properly awaited.
4. Prioritize readability over 1:1 mapping.
5. Do not include Java-specific boilerplate (classes, main methods) unless requested.
6. Provide only the code wrapped in markdown blocks.
"@

$Payload = @{
    model = $Model
    messages = @(
        @{ role = "system"; content = $SystemPrompt },
        @{ role = "user"; content = "Convert this code to $Language:\n\n$SourceCode" }
    )
    stream = $false
} | ConvertTo-Json -Depth 10

try {
    $Response = Invoke-RestMethod -Uri $Endpoint -Method Post -Body $Payload -ContentType "application/json"
    $ConvertedCode = $Response.message.content
    
    # Extract code from markdown block if present
    if ($ConvertedCode -match "```[a-z]*\n([\s\S]*?)```") {
        $ConvertedCode = $Matches[1]
    }

    # Save to converted directory
    $Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $FileName = "converted_$Timestamp.$($Language -match 'typescript' ? 'ts' : 'js')"
    $FilePath = Join-Path "converted" $FileName
    $ConvertedCode | Out-File -FilePath $FilePath -Encoding utf8

    # Output for UI
    $Output = @{
        success = $true
        convertedCode = $ConvertedCode
        filePath = $FilePath
    } | ConvertTo-Json
    Write-Output $Output
} catch {
    $ErrorObj = @{
        success = $false
        error = $_.Exception.Message
    } | ConvertTo-Json
    Write-Output $ErrorObj
}
