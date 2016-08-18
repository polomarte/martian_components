## Know More Links

Ver erat, et morbo Romæ languebat inertiOrbilius: dira tacuerunt tela magistri, Plagarumque sonus non jam veniebat ad aures, Nec ferula assiduo cruciabat membra dolore.

  ~~~~~ ruby
    KnowMoreLinks.create!(
    key: 'app:know_more_links:your_know_more_links_key',
    title: 'your_title',
    h1: 'your_h1',
    h2: 'your_h2',
    items: links, # This links will be your know_more_links list
    images: [build_image('image', 'icon.png')])
  ~~~~~

## Know More Link

But with the Know more links component, you will needed a KnowMoreLink list you can create that with:

  ~~~~~ ruby
# That's what i was talking about.
links = [
      KnowMoreLink.create!(
        key: 'app:know_more_link:know_more_link_a',
        h1: "About Me",
        h2: 'Ipsum volutpat consectetur orci metus consequat imperdiet duis integer semper magna.',
        link_url: 'www.google.com.br',
        images: [build_image('image', 'icon.png')]),

      KnowMoreLink.create!(
        key: 'app:know_more_link:know_more_link_b',
        h1: "About Us",
        h2: 'Ipsum volutpat consectetur orci metus consequat imperdiet duis integer semper magna.',
        link_url: 'www.google.com.br',
        images: [build_image('image', 'icon.png')]),

      KnowMoreLink.create!(
        key: 'app:know_more_link:know_more_link_c',
        h1: "About You",
        h2: 'Ipsum volutpat consectetur orci metus consequat imperdiet duis integer semper magna.',
        link_url: 'www.google.com.br',
        images: [build_image('image', 'icon.png')])
]
  ~~~~~
