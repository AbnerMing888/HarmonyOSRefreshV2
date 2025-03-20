import { ViewPager } from '@abner/tab'
import { CommunityView } from './CommunityView'
import { RefreshLayoutStatus, RefreshArcView } from '@abner/refresh_v2'

/**
 * AUTHOR:AbnerMing
 * DATE:2025/3/20
 * INTRODUCE:一楼视图
 * */
@ComponentV2
export struct FirstFloorView {
  @Param onChange?: (position: number) => void = undefined //页面滑动监听
  @Param currentIndex?: number = 0 //默认第0个
  @Param onScrollStart?: (isRefreshStart: boolean) => void = undefined
  @Param firstScrollDistance?: number = 0 //一楼滑动距离
  @Param refreshLayoutStatus?: RefreshLayoutStatus = RefreshLayoutStatus.Pulling //当前的刷新状态
  private arcMaxHeight: number = 40

  @Builder
  itemLayout(position: number, _this: FirstFloorView) {
    //可根据索引 进行设置不同的页面
    if (position == 1) {
      Column() {
        //顶部的弧度
        RefreshArcView({
          arcHeight: _this.firstScrollDistance! > this.arcMaxHeight ? this.arcMaxHeight : _this.firstScrollDistance
        })
        CommunityView({
          onScrollStart: _this.onScrollStart,
          firstScrollDistance: _this.firstScrollDistance,
          refreshLayoutStatus: _this.refreshLayoutStatus
        }).margin({ top: -2 })

      }.height("100%")
      .width("100%")
    } else {

      Column() {
        Text("我是条目" + position)
      }.height("100%")
      .width("100%")
      .backgroundColor(Color.White)

    }

  }

  build() {
    ViewPager({
      pageSize: 5,
      onChange: this.onChange,
      itemLayout: (position: number) => {
        this.itemLayout(position, this)
      },
      currentIndex: this.currentIndex
    })
  }
}