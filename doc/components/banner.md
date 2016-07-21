## Banner

Ver erat, et morbo Romæ languebat inertiOrbilius: dira tacuerunt tela magistri, Plagarumque sonus non jam veniebat ad aures, Nec ferula assiduo cruciabat membra dolore.

  ~~~~~ ruby
  Banner.create!(
  key: 'app:banner:your_banner_key',
  title: 'your_title',
  h1: 'your_h1',
  h2: 'your_h2',
  images: [
    build_image('icon', 'you_icon.png'),
    build_image('background', 'your_background.jpg')],
  options: {data: {full_height_header: true}})
  ~~~~~

