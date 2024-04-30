local symbols_outline_setup, symbols_outline = pcall(require, "symbols-outline")
if not symbols_outline_setup then
	return
end

symbols_outline.setup()
