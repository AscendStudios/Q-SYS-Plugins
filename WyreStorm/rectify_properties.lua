if props.plugin_show_debug.Value == false then
  props["Debug Print"].IsHidden = true
end
if props["Enable Dev"].Value == false then
  props["Port"].IsHidden = true
end
