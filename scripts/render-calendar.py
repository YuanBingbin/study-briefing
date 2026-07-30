from playwright.sync_api import sync_playwright

html_path = r"d:\CodeFold\helper\study-assistant\plans\calendar.html"
png_path = r"d:\CodeFold\helper\study-assistant\plans\calendar.png"

with sync_playwright() as p:
    browser = p.chromium.launch()
    page = browser.new_page(viewport={"width": 1400, "height": 2000})
    page.goto(f"file:///{html_path.replace(chr(92), '/')}")
    page.wait_for_timeout(500)
    page.screenshot(path=png_path, full_page=True)
    browser.close()

print(f"PNG saved to: {png_path}")