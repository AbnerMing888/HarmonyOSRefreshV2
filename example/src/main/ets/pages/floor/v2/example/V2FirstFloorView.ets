import { ViewPager } from '@abner/tab'
import { RefreshLayoutStatus, RefreshArcView } from '@abner/refresh_v2'
import { V2CommunityView } from './V2CommunityView'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/5/27
 * INTRODUCE:一楼视图
 * */
@ComponentV2
export struct V2FirstFloorView {
  @Param onChange?: (position: number) => void = undefined //页面滑动监听
  @Param currentIndex?: number = 0 //默认第0个
  @Param onScrollStart?: (isRefreshStart: boolean) => void = undefined
  @Param firstScrollDistance?: number = 0 //一楼滑动距离
  @Param refreshLayoutStatus?: RefreshLayoutStatus = RefreshLayoutStatus.Pulling //当前的刷新状态
  private arcMaxHeight: number = 40

  @Builder
  itemLayout(position: number) {
    //可根据索引 进行设置不同的页面
    if (position == 1) {
      Column() {
        //顶部的弧度
        RefreshArcView({
          arcHeight: this.firstScrollDistance! > this.arcMaxHeight ? this.arcMaxHeight : this.firstScrollDistance
        })
        V2CommunityView({
          onScrollStart: this.onScrollStart,
          firstScrollDistance: this.firstScrollDistance,
          refreshLayoutStatus: this.refreshLayoutStatus
        }).margin({ top: -2 })

      }.height("100%")
      .width("100%")
    } else {

      Column() {
        Text("我是条目" + position)
      }.height("100%")
      .width("100%")
      .backgroundColor(Color.White)
      .justifyContent(FlexAlign.Center)

    }

  }

  build() {
    ViewPager({
      pageSize: 5,
      onChange: this.onChange,
      itemLayout: (position: number) => {
        this.itemLayout(position)
      },
      currentIndex: this.currentIndex
    })
  }
}