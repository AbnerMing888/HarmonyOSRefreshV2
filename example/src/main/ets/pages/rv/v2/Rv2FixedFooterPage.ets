import { RefreshController, RefreshView } from '@abner/refresh_v2'
import { TitleBar } from '@abner/bar'
import { RouterPath } from '@abner/router'
import { ListItemV2View } from '../../../view/ListItemV2View'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/11/13
 * INTRODUCE:上拉加载，底部的暂无更多，固定
 * */
@RouterPath("example_Rv2FixedFooterPage")
@ComponentV2
export struct Rv2FixedFooterPage {
  @Local testArray: number[] = []
  scroller: Scroller = new Scroller()
  controller: RefreshController = new RefreshController()
  aboutToAppear(): void {
    for (let i = 0; i < 20; i++) {
      this.testArray.push(i)
    }
  }
  @Builder
  itemLayout() {
    List({ scroller: this.scroller}) {
      ForEach(this.testArray, (_: number,index:number) => {
        ListItem() {
          ListItemV2View({index:index})
        }
      }, (item: string, index: number) => JSON.stringify(item) + "_" + index)
    }
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.None)
    .width("100%")
    .height("100%")
    .padding({ left: 10, right: 10 })
    .nestedScroll({
      scrollForward: NestedScrollMode.SELF_FIRST,
      scrollBackward: NestedScrollMode.PARENT_FIRST
    })
  }

  build() {
    Column() {

      TitleBar({
        title: "(V2)【固定底部暂无更多数据】"
      })

      RefreshView({
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
            for (let i = 10; i < 20; i++) {
              this.testArray.push(i)
            }
            this.controller.finishLoadMoreFixedBottom(true) //固定暂无更多数据，不会回弹
          }, 2000)
        }
      })
    }
  }
}