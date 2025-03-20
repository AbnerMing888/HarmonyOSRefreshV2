import { RefreshController, RefreshLayoutStatus, FloorStaggeredGridView, RefreshPositionEnum } from '@abner/refresh_v2'


/**
 * AUTHOR:AbnerMing
 * DATE:2025/3/20
 * INTRODUCE:社区视图
 * */

@ComponentV2
export struct CommunityView {
  @Local controller: RefreshController = new RefreshController() //刷新控制器
  private itemHeightArray: number[] = []
  @Local array: Array<number> = []
  @Local colors: number[] = [0xFFC0CB, 0xDA70D6, 0x6B8E23, 0x6A5ACD, 0x00FFFF, 0x00FF7F]
  @Local minSize: number = 80
  @Local maxSize: number = 180
  scroller: Scroller = new Scroller()
  @Param onScrollStart?: (isRefreshStart: boolean) => void = undefined
  @Local enableScrollInteraction?: boolean = true
  @Param refreshLayoutStatus?: RefreshLayoutStatus = RefreshLayoutStatus.Pulling //当前的刷新状态
  @Param firstScrollDistance?: number = 0 //一楼滑动距离

  /*
  * Author:AbnerMing
  * Describe:一楼滑动监听
  */
  @Monitor("firstScrollDistance")
  firstScrollListener() {
    this.enableScrollInteraction = this.firstScrollDistance! < 1

  }

  // 计算FlowItem宽/高
  getSize() {
    let ret = Math.floor(Math.random() * this.maxSize)
    return (ret > this.minSize ? ret : this.minSize)
  }

  // 设置FlowItem的宽/高数组
  setItemSizeArray() {
    for (let i = 0; i < 100; i++) {
      this.array.push(i)
      this.itemHeightArray.push(this.getSize())
    }
  }

  aboutToAppear() {
    this.setItemSizeArray()
  }

  @Builder
  itemLayout(item: Object, index: number): void {
    Column() {
      Text("测试数据" + index)
    }.width("100%")
    .height(this.itemHeightArray[index % 100])
    .backgroundColor(this.colors[index % 5])

  }

  /*
  * Author:AbnerMing
  * Describe:头部组件，可以作为轮播、金刚位等
  */
  @Builder
  itemHeaderLayout(_this: CommunityView) {
    Column() {

    }.width("100%")
    .height(200)
    .backgroundColor(Color.Pink)
    .onClick(() => {
      //未滑动时执行点击
      if (_this.firstScrollDistance == 0) {
        console.log("===============我点击了")
      }
    })
  }

  build() {
    Column() {
      FloorStaggeredGridView({
        items: this.array,
        itemLayout: (item: Object, index: number) => this.itemLayout(item, index),
        controller: this.controller,
        itemHeaderLayout: () => {
          this.itemHeaderLayout(this)
        },
        isParentControlInteraction: false, //是否父类拦截
        enableScrollInteraction: this.enableScrollInteraction,
        reachPosition: (refreshPosition: RefreshPositionEnum) => {
          if (this.onScrollStart != undefined) {
            this.onScrollStart(refreshPosition == RefreshPositionEnum.TOP)
          }
        },
        onScrollIndex: () => {
          console.log("====" + this.controller.getLoadMoreLayoutStatus())
        },
        onLoadMore: () => {
          //上拉加载
          setTimeout(() => {
            this.controller.finishLoadMore()
          }, 3000)
        }
      })
    }.padding({ bottom: 120 }) //动态控制
    .backgroundColor(Color.White)

  }
}