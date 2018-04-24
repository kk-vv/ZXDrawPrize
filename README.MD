### `iOS  Lottery`


#### `About Draw`

|centerRadius = 0|centerRadius = 30|
|--------|--------|
|![T1](https://github.com/iFallen/ZXDrawPrize/raw/master/images/T1.png)|![T2](https://github.com/iFallen/ZXDrawPrize/raw/master/images/T2.png)|

>
中间有 `指针` 图标覆盖，所以在显示上没啥区别

#### `GIF`
| GIF |
|--------|
|![T1](https://github.com/iFallen/ZXDrawPrize/raw/master/images/demo.gif)|

#### `IMG`
| 3 | 6 | 8 | 20 |
|--------|--------|--------|--------|
|![3](https://github.com/iFallen/ZXDrawPrize/raw/master/images/1.png)|![6](https://github.com/iFallen/ZXDrawPrize/raw/master/images/2.png)|![8](https://github.com/iFallen/ZXDrawPrize/raw/master/images/3.png)|![20](https://github.com/iFallen/ZXDrawPrize/raw/master/images/4.png)|

#### `Init`

```
drawPrizeView = ZXDrawPrizeView.init(CGPoint(x: 100, y: 100), width: 400)
self.view.addSubview(drawPrizeView)
drawPrizeView.delegate = self
drawPrizeView.dataSource = self
```


#### `DataSouce`

```
///奖品格子数量
func numberOfPrize(for drawprizeView: ZXDrawPrizeView) -> NSInteger
///商品图片(包括谢谢参与)
//本地图片(二选一 优先)
func zxDrawPrize(prizeView: ZXDrawPrizeView, imageAt index: NSInteger) -> UIImage?
//网络图片(二选一)
func zxDrawPrize(prizeView: ZXDrawPrizeView, imageUrlAt index: NSInteger) -> String?
///某项奖品抽完
func zxDrawPrize(prizeView: ZXDrawPrizeView, drawOutAt index: NSInteger) -> Bool
///点击抽奖按钮
func zxDrawPrizeButtonImage(prizeView: ZXDrawPrizeView) -> UIImage
///大背景
func zxDrawPrizeBackgroundImage(prizeView: ZXDrawPrizeView) -> UIImage?
///滚动背景
func zxDrawPrizeScrollBackgroundImage(prizeView: ZXDrawPrizeView) -> UIImage?
```

#### `Delegate`

```
///点击抽奖按钮
func zxDrawPrizeStartAction(prizeView: ZXDrawPrizeView)
///抽奖结束
func zxDrawPrizeEndAction(prizeView: ZXDrawPrizeView, prize index: NSInteger)
```

#### `RUN`

```
execute `pod install` in `Terminal` ,before run demo project.
```

- `If Copy,Pls Keep The Writer Info.`