import { RefreshController, WaterFlowLayout } from '@abner/refresh_v2'
import { RouterPath } from '@abner/router'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/7/16
 * INTRODUCE:交错布局吸顶页面 案例
 * */

@RouterPath("example_FlowLayoutV2StickyTopPage")
@ComponentV2
export struct FlowLayoutV2StickyTopPage {
  build() {
    Scroll() {
      Column() {
        Text("头View")
          .fontColor(Color.White)
          .width("100%")
          .height("40%")
          .backgroundColor($r("app.color.tab_select_color"))
          .textAlign(TextAlign.Center)

        Tabs({ barPosition: BarPosition.Start }) {
          TabContent() {
            this.testLayout(0)
          }.tabBar("Tab1")

          TabContent() {
            this.testLayout(1)
          }.tabBar("Tab2")
        }
        .vertical(false)
        .height("100%")
      }.width("100%")
    }
    .scrollBar(BarState.Off)
    .width('100%')

  }

  /*
  * Author:AbnerMing
  * Describe:这里仅仅是测试，实际应以业务需求为主，可以是任意得组件视图
  */
  @Builder
  testLayout(type: number) {
    StickyGridView({ pageType: type })
  }
}

/*
* Author:AbnerMing
* Describe:吸顶列表
*/
@ComponentV2
struct StickyGridView {
  @Param pageType: number = 0
  controller: RefreshController = new RefreshController() //刷新控制器
  @Local arr1: number[] = [] //实际情况当以tab指示器对应得数据为主，这里仅仅是测试
  @Local arr2: number[] = []
  private itemHeightArray: number[] = []
  private itemHeightArray2: number[] = []
  @Local colors: ResourceColor[] = ["#ee6d82", "#e5682f", "#eeb272", "#cbb41b", "#d86fea", "#5f97ea"]
  @Local minSize: number = 80
  @Local maxSize: number = 180

  // 计算FlowItem宽/高
  getSize() {
    let ret = Math.floor(Math.random() * this.maxSize)
    return (ret > this.minSize ? ret : this.minSize)
  }

  aboutToAppear() {
    for (let i = 0; i < 50; i++) {
      this.arr1.push(i)
      this.itemHeightArray.push(this.getSize())
    }
    for (let i = 0; i < 50; i++) {
      this.arr2.push(i)
      this.itemHeightArray2.push(this.getSize())
    }
  }

  @Builder
  itemLayout(_: Object, index: number) {
    Column() {
      Text("列表数据:" + index)
        .fontColor(Color.White)
    }
    .justifyContent(FlexAlign.Center)
    .width("100%")
    .height(this.pageType == 0 ? this.itemHeightArray[index % 100] : this.itemHeightArray2[index % 100])
    .backgroundColor(this.colors[index % 5])
  }

  build() {
    WaterFlowLayout({
      items: this.pageType == 0 ? this.arr1 : this.arr2,
      itemLayout: (item: Object, index: number) => {
        this.itemLayout(item, index)
      },
      controller: this.controller,
      nestedScroll: {
        scrollForward: NestedScrollMode.PARENT_FIRST,
        scrollBackward: NestedScrollMode.SELF_FIRST
      }
    })
  }
}