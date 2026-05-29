import { RefreshHeaderType, SecondFloorLayout,
  SfRefreshController } from '@abner/refresh_v2'
import { RouterPath } from '@abner/router'
import { window } from '@kit.ArkUI'

@RouterPath("example_SecondFloorPageV2")
@ComponentV2
export struct SecondFloorPageV2 {
  @Local sfController: SfRefreshController = new SfRefreshController()
  @Local topViewHeight: number = 44
  @Local statusBarHeight: number = 50
  @Local mScrollInteraction: boolean = true
  scroller: Scroller = new Scroller()

  aboutToAppear(): void {
    try {
      window.getLastWindow(this.getUIContext().getHostContext()).then((win) => {
        let avoidArea = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM)
        let topRectHeight = avoidArea.topRect.height
        this.statusBarHeight = this.getUIContext().px2vp(topRectHeight)
      })
    } catch (e) {
    }
  }

  /*
  * Author:AbnerMing
  * Describe:一楼视图
  */
  @Builder
  firstFloorView() {
    Scroll(this.scroller) {
      Image($r("app.media.taobao_index"))
        .width("100%")
    }
    .width("100%")
    .height("100%")
    .scrollBar(BarState.Off)
    .enableScrollInteraction(this.mScrollInteraction)
  }

  /*
 * Author:AbnerMing
 * Describe:二楼视图
 */
  @Builder
  secondFloorView() {
    Column() {
      Image($r("app.media.taobao_second_floor"))
        .width("100%")
        .height("100%")
    }
    .width("100%")
    .height("100%")
  }

  /*
 * Author:AbnerMing
 * Describe:顶部固定视图
 */
  @Builder
  topFixedView() {
    Column() {
      Text("(V2)淘宝二楼")
        .fontColor(Color.White)
    }
    .width("100%")
    .height(this.topViewHeight + this.statusBarHeight)
    .padding({ top: this.statusBarHeight })
    .backgroundColor($r("app.color.tab_select_color"))
    .justifyContent(FlexAlign.Center)
  }

  build() {
    RelativeContainer() {
      SecondFloorLayout({
        childScroller: this.scroller,
        firstFloorView: () => { //一楼视图
          this.firstFloorView()
        },
        isNeedHalfFloor: true, //是否需要半楼功能
        secondFloorView: this.secondFloorView, //二楼视图
        enableScrollInteraction: (isInteraction: boolean) => {
          //用于解决嵌套的滑动组件冲突
          this.mScrollInteraction = isInteraction
        },
        topFixedView: () => {
          //顶部固定视图
          this.topFixedView()
        },
        sfController: this.sfController, //刷新控制器
        refreshHeaderAttribute: (attr) => {
          //刷新头及二楼滑动属性配置
          attr.fontColor = Color.White
          attr.timeFontColor = Color.White
          attr.headerType = RefreshHeaderType.POINTS
        },
        onRefresh: () => {
          //下拉刷新
          setTimeout(() => {
            this.sfController.finishRefresh()
          }, 2000)
        },
        onScrollStatus: (status) => {
          //当前的滑动状态
        }
      })
        .id('SecondFloorView')
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
    }
    .height('100%')
    .width('100%')
  }
}