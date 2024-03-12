-- Optional function used if plugin has multiple pages
PageNames = { "Control", "Passcode", "Configuration", "About" }  --List the pages within the plugin
function GetPages(props)
  local pages = {}
  for ix in ipairs(PageNames) do
    table.insert(pages, { name = PageNames[ix] })
  end

  return pages
end
