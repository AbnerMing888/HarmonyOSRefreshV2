import webview from '@ohos.web.webview';
import { TitleBar } from '@abner/bar'
import { LitheRefresh, RefreshController } from '@abner/refresh_v2';
import { RouterPath } from '@abner/router';

/**
 * AUTHOR:AbnerMing
 * DATE:2025/7/15
 * INTRODUCE:Web组件
 * */
@RouterPath("example_LitheV2WebViewPage")
@ComponentV2
export struct LitheV2WebViewPage {
  @Local controller: RefreshController = new RefreshController() //刷新控制器
  webviewController: webview.WebviewController = new webview.WebviewController();
  @Local isWebTop: boolean = true //判断web是否到达了顶端

  @Builder
  itemLayout() {
    //可以是任何的组件
    Web({ src: "https://juejin.cn/user/1398234520239095/columns", controller: this.webviewController })
      .width("100%")
      .nestedScroll({
        scrollForward: NestedScrollMode.SELF_FIRST,
        scrollBackward: NestedScrollMode.PARENT_FIRST
      })
      .onScroll((event) => {
        this.isWebTop = event.yOffset == 0 //判断web是否滑动到顶部
      })
      .onPageEnd(() => {
        //默认不可滑动
        this.webviewController.setScrollable(false)
      })
  }

  build() {
    Column() {
      TitleBar({ title: "(V2)Web组件" })

      LitheRefresh({
        controller: this.controller,
        itemLayout: () => {
          this.itemLayout()
        },
        isWebTop: this.isWebTop,
        onScrollDirection: (isDown: boolean) => {
          if (this.isWebTop) {
            //在顶部，需要判断手势是往下还是往上
            this.webviewController.setScrollable(!isDown)
          } else {
            //不在顶部，一律可滑动
            this.webviewController.setScrollable(true)
          }
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