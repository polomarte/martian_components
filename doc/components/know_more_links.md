## Know More Links

Ver erat, et morbo Romæ languebat inertiOrbilius: dira tacuerunt tela magistri, Plagarumque sonus non jam veniebat ad aures, Nec ferula assiduo cruciabat membra dolore.

  ~~~~~ ruby
    KnowMoreLinks.create!(
    key: 'app:know_more_links:your_know_more_links_key',
    title: 'your_title',
    h1: 'your_h1',
    h2: 'your_h2',
    items: links, # this links will be your know_more_links list
    images: [build_image('image', 'icon.png')])
  ~~~~~

but with the Know more links component, you will needed a know_more_link list
