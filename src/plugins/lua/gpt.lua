local settings = {
  api_key = nil,
  model = 'gpt-3.5-turbo',
  temperature = 0.7,
  max_tokens = 150,
  exclude_body = false, -- New option to exclude email body content
  -- ... existing code ...
}

local function default_condition(task)
  local content = ''
  local selected_part = nil
  
  if not settings.exclude_body then
    local parts = task:get_text_parts()
    if parts then
      for _, part in ipairs(parts) do
        if part:is_html() then
          selected_part = part
          break
        end
      end
      if not selected_part and #parts > 0 then
        selected_part = parts[1]
      end
    end
    if selected_part then
      content = selected_part:get_content()
    end
  end
  
  return content, selected_part
end

-- ... existing code ... 