import 'package:shop_web_app/product.dart';

///Класс реализует добавление в лист продукты из базы данных
class AddListProduct {
  var productList = <Product>[
    Product(
        'Яблоки',
        'Вкусные и полезные яблоки',
        'Яблоки представляют собой плоды круглой, удлинённой или овальной '
            'формы, имеют твёрдую кожуру зелёного, красного, белого, жёлтого '
            'или смешанного цвета, сочную твёрдую мякоть, плодоножку и '
            'небольшие семечки внутри фрукта',
        200,
        'apple.jpg'),
    Product(
        'Груши',
        'Большие груши',
        'Груши являются климактерическими '
            'плодами, вместе с их твёрдостью вкусовые качества быстро '
            'снижаются. Дата сбора важна в отношении сохранения качества и '
            'достижения оптимального вкуса.',
        500,
        'pear.jpeg'),
    Product(
        'Груши',
        'Большие груши',
        'Груши являются климактерическими '
            'плодами, вместе с их твёрдостью вкусовые качества быстро '
            'снижаются. Дата сбора важна в отношении сохранения качества и '
            'достижения оптимального вкуса.',
        500,
        'pear.jpeg'),
  ];
}
