import {
  RefreshController, RefreshLayoutStatus, RefreshPositionEnum, FloorListView
} from '@abner/refresh_v2'
import { ListItemV2View } from '../../../../view/ListItemV2View'


/**
 * AUTHOR:AbnerMing
 * DATE:2024/5/27
 * INTRODUCE:社区视图
 * */

@ComponentV2
export struct V2CommunityView2 {
  @Local controller: RefreshController = new RefreshController() //刷新控制器
  @Local array: Array<number> = []
  @Param scroller: Scroller = new Scroller()
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

  aboutToAppear() {
    for (let i = 0; i < 50; i++) {
      this.array.push(i)
    }
  }

  @Builder
  itemLayout(_: Object, index: number): void {
    ListItemV2View({ index: index })
  }

  /*
  * Author:AbnerMing
  * Describe:头部组件，可以作为轮播、金刚位等
  */
  @Builder
  itemHeaderLayout() {
    Column() {

    }
    .width("100%")
    .height(200)
    .backgroundColor($r("app.color.tab_select_color"))
    .margin({ bottom: 10 })
    .onClick(() => {
      //未滑动时执行点击
      if (this.firstScrollDistance == 0) {
        console.log("===============我点击了")
      }
    })
  }

  build() {
    FloorListView({
      items: this.array,
      controller: this.controller,
      itemHeaderLayout: () => {
        this.itemHeaderLayout()
      },
      itemLayout: (item: Object, index: number) => this.itemLayout(item, index),
      enableScrollInteraction: this.enableScrollInteraction,
      reachPosition: (refreshPosition: RefreshPositionEnum) => {
        if (this.onScrollStart != undefined) {
          this.onScrollStart(refreshPosition == RefreshPositionEnum.TOP)
        }
      },
      onLoadMore: () => {
        //上拉加载
        setTimeout(() => {
          this.controller.finishLoadMoreFixedBottom(true)
        }, 3000)
      }
    }).backgroundColor(Color.White)
  }
}