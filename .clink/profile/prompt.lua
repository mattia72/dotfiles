function lambda_prompt_filter()
    clink.prompt.value = string.gsub(clink.prompt.value, "{lamb}", "λ")
    clink.prompt.value = string.gsub(clink.prompt.value, "{arrow}", "»")
end

clink.prompt.register_filter(lambda_prompt_filter, 40)
