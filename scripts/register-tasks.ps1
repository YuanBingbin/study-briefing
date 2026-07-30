# register-tasks.ps1
# 注册 4 个 Windows 定时任务，到点通过 Server酱 推送微信提醒

$scriptPath = "d:\CodeFold\helper\study-assistant\scripts\study-reminder.ps1"
$userName = whoami

$tasks = @(
    @{
        Name     = "StudyAssistant-Morning"
        Title    = "Morning Briefing"
        Message  = "Time for morning commute study. Open Claude to get your daily briefing."
        Days     = "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"
        Time     = "07:40"
    },
    @{
        Name     = "StudyAssistant-Lunch"
        Title    = "Lunch Practice"
        Message  = "Lunch break study time. Open Claude for 15 quick practice questions."
        Days     = "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"
        Time     = "12:30"
    },
    @{
        Name     = "StudyAssistant-Evening"
        Title    = "Evening Study"
        Message  = "Evening study time. Open Claude for your 3-hour study plan."
        Days     = "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"
        Time     = "19:00"
    },
    @{
        Name     = "StudyAssistant-Weekend"
        Title    = "Weekend Mock Exam"
        Message  = "Saturday mock exam time. Open Claude for a full practice test."
        Days     = "Saturday"
        Time     = "09:00"
    }
)

foreach ($task in $tasks) {
    $arguments = "-ExecutionPolicy Bypass -File `"$scriptPath`" -Title `"$($task.Title)`" -Message `"$($task.Message)`""

    $action = New-ScheduledTaskAction -Execute "powershell" -Argument $arguments
    $trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek $task.Days -At $task.Time
    $principal = New-ScheduledTaskPrincipal -UserId $userName -LogonType Interactive

    Register-ScheduledTask -TaskName $task.Name -Action $action -Trigger $trigger -Principal $principal -Force
    Write-Host "[OK] Registered: $($task.Name) at $($task.Time) on $($task.Days -join ',')"
}

Write-Host ""
Write-Host "All 4 study reminder tasks registered successfully!"
Write-Host "Open Task Scheduler (taskschd.msc) to view/edit them."