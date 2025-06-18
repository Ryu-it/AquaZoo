areas = [
  { name: "北海道" },
  { name: "東北" },
  { name: "関東" },
  { name: "中部" },
  { name: "北陸" },
  { name: "近畿" },
  { name: "中国" },
  { name: "四国" },
  { name: "九州" },
  { name: "沖縄" }
]

areas.each do |area|
  Area.find_or_create_by(name: area[:name])
end

categories = [
  { name: "zoo" },
  { name: "aqua" }
]

categories.each do |category|
  Category.find_or_create_by(name: category[:name])
end
