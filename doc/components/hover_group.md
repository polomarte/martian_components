## Hover Group

Ver erat, et morbo Romæ languebat inertiOrbilius: dira tacuerunt tela magistri, Plagarumque sonus non jam veniebat ad aures, Nec ferula assiduo cruciabat membra dolore.

  ~~~~~ ruby
    HoverGroup.create!(
        key:          'home:hover_group:highlights',
        h1:           'Your main h1 text',
        h2:           'Últimas novidades Amanco',
        items:        items, # This links will be your know_more_links list
        form_options: {only_items: true},
        options: {
          gallery: true,
          gallery_options: load_yaml('home/home.yml')['highlights_gallery_options']})
  ~~~~~

## Hover Item

But with the Know more links component, you will needed a KnowMoreLink list you can create that with:

  ~~~~~ ruby
# That's what i was talking about.
 items = [
        HoverItem.create!(
          key: 'home:hover_item:your_hover_item_key',
          h1: 'Your h1 text',
          link_url: https://github.com/polomarte/martian_components,
          images: [
            build_image('background', 'background.png'),
            build_image('icon', 'icon.png')],
          form_options: {
            additional_editable_attrs: [:link_url],
            disabled_attrs: [:text]}),

        HoverItem.create!(
          key: 'home:hover_item:your_hover_item_key',
          h1: 'Your h1 text',
          link_url: https://github.com/polomarte/martian_components,
          images: [
            build_image('background', 'background.png'),
            build_image('icon', 'icon.png')],
          form_options: {
            additional_editable_attrs: [:link_url],
            disabled_attrs: [:text]}),

        HoverItem.create!(
          key: 'home:hover_item:your_hover_item_key',
          h1: 'Your h1 text',
          link_url: https://github.com/polomarte/martian_components,
          images: [
            build_image('background', 'background.png'),
            build_image('icon', 'icon.png')],
          form_options: {
            additional_editable_attrs: [:link_url],
            disabled_attrs: [:text]})]
  ~~~~~
