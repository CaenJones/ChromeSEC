Jekyll::Hooks.register :pages, :post_render do |page|
  if page.name == "Acknowledgements.md"
    puts page.content
  end
end