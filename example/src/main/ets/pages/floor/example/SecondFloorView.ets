import { GridView, RefreshLayoutStatus } from '@abner/refresh_v2'

/**
 * AUTHOR:AbnerMing
 * DATE:2025/3/20
 * INTRODUCE:二楼视图
 * */
@ComponentV2
export struct SecondFloorView {
  @Param onBackFirstFloor?: () => void = undefined
  @Param statusBarHeight?: number = 0
  @Param firstScrollDistance: number = 0 //一楼滑动距离
  @Param refreshLayoutStatus: RefreshLayoutStatus = RefreshLayoutStatus.Pulling
  @Local itemScale: number = 0.8 //默认放大倍数
  @Local isHideTopLayer: boolean = false //顶部的蒙层
  @Param isActionStart: number = 0

  /*
  * Author:AbnerMing
  * Describe:
  */
  @Monitor("isActionStart")
  actionStartListener() {
    if (this.refreshLayoutStatus < RefreshLayoutStatus.HalfFloor) {
      this.itemScale = 0.8
    }
  }

  /*
  * Author:AbnerMing
  * Describe:滑动状态监听
  */
  @Monitor("refreshLayoutStatus")
  scrollStatusListener() {
    if (this.refreshLayoutStatus >= RefreshLayoutStatus.HalfFloor) {
      //大于等于半楼
      this.isHideTopLayer = true
    } else {
      this.isHideTopLayer = false
    }
  }

  /*
  * Author:AbnerMing
  * Describe:滑动距离监听
  */
  @Monitor("firstScrollDistance")
  scrollDistanceListener() {
    if (this.refreshLayoutStatus < RefreshLayoutStatus.HalfFloor) {
      if (this.itemScale < 1) {
        this.itemScale = 0.8 + this.firstScrollDistance / 1000
      } else {
        this.itemScale = 1
      }
    }
  }

  @Builder
  itemLayout(item: Object, index: number) {
    //测试数据
    Stack() {
      Image($r("app.media.second_image1"))
        .width("100%")
        .height(120)
        .borderRadius(8)
    }.onClick(() => {
      console.log("================" + index)
    })
  }

  build() {
    Stack() {
      Column()
        .width("100%")
        .height("100%")
        .linearGradient({
          angle: 90,
          colors: [["#ff272E37", 0.0], ["#ff464A67", 1]]
        })

      Column() {

        Column() {
          Text("品牌专区")
            .fontColor("#ffFFFFFF")
            .fontSize(15)
            .width("100%")
            .textAlign(TextAlign.Start)
            .margin({ top: 20 + this.statusBarHeight!, left: 20, bottom: 16 })

          GridView({
            items: [1, 2, 3, 4, 5],
            columnSize: 2,
            itemLayout: this.itemLayout,
            gridAttribute: (attr) => {
              attr.height = 400
              attr.rowsGap = 12
              attr.columnsGap = 12
            }
          })
            .margin({ left: 8, right: 8 }) //这里要减去列与列的边距

        }.scale({ x: this.itemScale, y: this.itemScale })

        Button("回到首页")
          .onClick(() => {
            if (this.onBackFirstFloor != undefined) {
              this.onBackFirstFloor()
            }
          })


      }.width("100%")
      .height("100%")
      .linearGradient({
        angle: 90,
        colors: [["#00000000", 0.0], ["#546C230A", 1]]
      })


      Column() {

      }
      .width("100%")
      .height("100%")
      .opacity(0.3)
      .backgroundColor("#000000")
      .visibility(this.isHideTopLayer ? Visibility.None : Visibility.Visible)

    }.width("100%")
    .height("100%")

  }
}