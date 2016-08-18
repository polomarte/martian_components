## Banner

The banner will be the first thing the user will see , it must have an id , a key, a title and some optional properties. Like h1 and h2 elements.

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

