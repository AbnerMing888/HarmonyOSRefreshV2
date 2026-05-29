import {
  RefreshHeaderType, RefreshLayoutStatus, SecondFloorLayout, SfRefreshController,
} from '@abner/refresh_v2'
import { RouterPath } from '@abner/router'
import { V2SecondFloorView } from '../example/V2SecondFloorView'
import { V2TopFixedView } from '../example/V2TopFixedView'
import { V2FirstFloorView2 } from './V2FirstFloorView2'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/5/27
 * INTRODUCE:二楼举例(List列表)
 * */
@RouterPath("example_V2SecondFloorExample2")
@ComponentV2
export struct V2SecondFloorExample2 {
  @Local sfController: SfRefreshController = new SfRefreshController()
  @Local topViewHeight: number = 84
  @Local statusBarHeight: number = 0
  @Local mScrollInteraction: boolean = true
  @Local currentIndex?: number = 0
  @Local showSecondFloorStatus?: boolean = false //是否显示刷新状态
  @Local refreshLayoutStatus?: RefreshLayoutStatus = RefreshLayoutStatus.Pulling
  @Local isScrollSecondFloor?: boolean = true //默认滑动
  @Local firstScrollDistance?: number = 0 //一楼滑动距离
  @Local isActionStart: number = 0
  @Local isSecondFloorLayoutEnabled: boolean = true
  @Local topViewOpacity: number = 1

  /*
  * Author:AbnerMing
  * Describe:一楼视图
  */
  @Builder
  firstFloorView() {
    V2FirstFloorView2({
      currentIndex: this.currentIndex,
      firstScrollDistance: this.firstScrollDistance,
      refreshLayoutStatus: this.refreshLayoutStatus,
      onChange: (position) => {
        //页面切换
        this.currentIndex = position
      },
      onScrollStart: (isRefreshStart: boolean) => {
        //是否是起始位置
        this.isScrollSecondFloor = isRefreshStart
      }
    })
      .width("100%")
      .height("100%")
  }

  /**
   *AUTHOR:AbnerMing
   *INTRODUCE:二楼视图
   */
  @Builder
  secondFloorView() {
    V2SecondFloorView({
      statusBarHeight: this.statusBarHeight,
      firstScrollDistance: this.firstScrollDistance,
      refreshLayoutStatus: this.refreshLayoutStatus,
      isActionStart: this.isActionStart,
      onBackFirstFloor: () => {
        //点击回到一楼
        this.sfController.backFirstFloor(true)
      }
    })
  }

  /**
   *AUTHOR:AbnerMing
   *INTRODUCE:固定视图
   */
  @Builder
  topFixedView() {
    Column() {
      Column() {

      }.width("100%")
      .height(50)
      .backgroundColor($r("app.color.tab_select_color"))

      V2TopFixedView({
        currentIndex: this.currentIndex,
        topViewOpacity: this.topViewOpacity,
        onTabClick: (position: number) => {
          this.currentIndex = position
        }
      })
        .width("100%")
        .height(this.topViewHeight)
        .padding({ top: this.statusBarHeight })
        .backgroundColor($r("app.color.tab_select_color"))
    }
  }

  build() {

    SecondFloorLayout({
      firstFloorView: () => {
        this.firstFloorView()
      }, //一楼视图
      isScrollSecondFloor: (this.currentIndex == 0 && this.isScrollSecondFloor) ? true : false,
      isNeedHalfFloor: true, //是否需要半楼功能
      showSecondFloorStatus: this.showSecondFloorStatus,
      secondFloorView: () => {
        this.secondFloorView()
      }, //二楼视图
      enableScrollInteraction: (isInteraction: boolean) => {
        //用于解决嵌套的滑动组件冲突
        this.mScrollInteraction = isInteraction
      },
      onTopViewOpacity: (opacity) => {
        this.topViewOpacity = opacity
      },
      topFixedView: () => {
        this.topFixedView()
      }, //顶部固定视图
      sfController: this.sfController, //刷新控制器
      refreshHeaderAttribute: (attr) => {
        //刷新头及二楼滑动属性配置
        attr.headerType = RefreshHeaderType.POINTS
        attr.releaseText = "松开立即刷新"
        attr.releaseHalfFloorText = "请下拉访问↓"
        attr.halfFloorText = "继续下拉查看更多↓"
        attr.releaseSecondFloorText = "继续下拉查看更多↓"
        attr.secondFloorText = ""
        attr.marginBottom = 0
        if (attr.headerPointsAttr != undefined) {
          attr.headerPointsAttr.secondFloorStatusText = "二楼可以访问品牌专区"
          attr.headerPointsAttr.fontColor = Color.White
          attr.headerPointsAttr.fontSize = 14 //文字大小
          attr.headerPointsAttr.secondFloorStatusFontWeight = FontWeight.Bold
        }
      },
      refreshAnimationDistance: 50,
      onScrollDistance: (distance) => {
        this.firstScrollDistance = distance
      },
      onRefresh: () => {
        //下拉刷新
        setTimeout(() => {
          this.sfController.finishRefresh()
        }, 5000)
      },
      onChangeScrollStatus: (status) => {

      },
      onScrollStatus: (status) => {
        //当前的滑动状态
        //这里判断，如果是刷新中，可以禁止页面滑动
        if (status == RefreshLayoutStatus.Refreshing) {
          this.isSecondFloorLayoutEnabled = false
        } else {
          this.isSecondFloorLayoutEnabled = true
        }

        if (status == RefreshLayoutStatus.ReleaseHalfFloor) {
          this.showSecondFloorStatus = true
        } else {
          this.showSecondFloorStatus = false
        }

        this.refreshLayoutStatus = status
        //如果滑动到了二楼，是否禁止二楼滑动
        this.isScrollSecondFloor = (status == RefreshLayoutStatus.SecondFloor) ? false : true

      },
      onActionStart: () => {
        //动作开始
        this.isActionStart++
      }
    }).enabled(this.isSecondFloorLayoutEnabled)

  }
}