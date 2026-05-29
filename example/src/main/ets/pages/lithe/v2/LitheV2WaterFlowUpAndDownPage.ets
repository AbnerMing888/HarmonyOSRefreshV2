import { TitleBar } from '@abner/bar'
import { LitheRefresh, RefreshController, RefreshDataSource } from '@abner/refresh_v2'
import { RouterPath } from '@abner/router'


/**
 * AUTHOR:AbnerMing
 * DATE:2024/11/13
 * INTRODUCE:WaterFlow 组件上拉下拉
 * */
@RouterPath("example_LitheV2WaterFlowUpAndDownPage")
@ComponentV2
export struct LitheV2WaterFlowUpAndDownPage {
  scroller: Scroller = new Scroller()
  controller: RefreshController = new RefreshController()

  @Builder
  itemLayout() {
    WaterFlowView({
      scroller: this.scroller
    })
  }

  build() {
    Column() {

      TitleBar({
        title: "(V2)WaterFlow组件刷新"
      })

      LitheRefresh({
        scroller: this.scroller,
        controller: this.controller,
        itemLayout: () => {
          this.itemLayout()
        },
        onRefresh: () => {
          //下拉刷新
          setTimeout(() => {
            this.controller.finishRefresh()
          }, 2000)
        },
        onLoadMore: () => {
          //上拉加载
          setTimeout(() => {
            this.controller.finishLoadMore()
          }, 2000)
        }
      })
    }
  }
}


@ComponentV2
struct WaterFlowView {
  @Local minSize: number = 80
  @Local maxSize: number = 180
  @Local fontSize: number = 24
  @Local colors: ResourceColor[] = ["#ee6d82", "#e5682f", "#eeb272", "#cbb41b", "#d86fea", "#5f97ea"]
  @Param scroller: Scroller = new Scroller()
  @Param dataSource: RefreshDataSource = new RefreshDataSource()
  private itemWidthArray: number[] = []
  private itemHeightArray: number[] = []

  // 计算FlowItem宽/高
  getSize() {
    let ret = Math.floor(Math.random() * this.maxSize)
    return (ret > this.minSize ? ret : this.minSize)
  }

  // 设置FlowItem的宽/高数组
  setItemSizeArray() {
    let tempArray: number[] = []
    for (let i = 0; i < 30; i++) {
      tempArray.push(i)
      this.itemWidthArray.push(this.getSize())
      this.itemHeightArray.push(this.getSize())
    }
    this.dataSource.initData(tempArray)
  }

  aboutToAppear() {
    this.setItemSizeArray()
  }

  build() {
    WaterFlow({ scroller: this.scroller }) {
      LazyForEach(this.dataSource, (item: number) => {
        FlowItem() {
          Column() {
            Text("列表数据:" + item)
              .fontSize(14)
              .height('16')
          }
        }
        .width('100%')
        .height(this.itemHeightArray[item % 30])
        .backgroundColor(this.colors[item % 5])
      }, (item: string) => item)
    }
    .columnsTemplate("1fr 1fr")
    .columnsGap(10)
    .rowsGap(5)
    .width('100%')
    .height('100%')
    .nestedScroll({
      scrollForward: NestedScrollMode.PARENT_FIRST,
      scrollBackward: NestedScrollMode.PARENT_FIRST
    })
  }
}