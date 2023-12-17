package com.taomee.seer2.app.rightToolbar.toolbar
{
   import com.taomee.seer2.app.config.ActCalendarConfig;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.rightToolbar.RightToolbar;
   import com.taomee.seer2.app.rightToolbar.config.RightToolbarInfo;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   import flash.utils.IDataInput;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.Tick;
   
   public class ActCalendarToolbar extends RightToolbar
   {
       
      
      private const TIMER_SEC:int = 120;
      
      public function ActCalendarToolbar()
      {
         super();
      }
      
      override public function init(param1:RightToolbarInfo) : void
      {
         super.init(param1);
         setShowTime(true,this.TIMER_SEC);
         update();
         if(_timeMC)
         {
            _timeMC.visible = false;
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         if(_rightClick == 0)
         {
            SwapManager.swapItem(info.swapId,1,function(param1:IDataInput):void
            {
               new SwapInfo(param1);
               _rightClick = 1;
               DisplayUtil.removeForParent(_conisMC);
            });
         }
         ModuleManager.toggleModule(URLUtil.getAppModule("ActCalendarPanel"),"正在打开赛尔新闻...");
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_421);
         _isShowTimeComplete = false;
         this.removeTimeComplete();
      }
      
      override protected function updateTimeMC(param1:uint) : void
      {
         if(_timeCount > 0)
         {
            --_timeCount;
         }
         if(_timeCount <= 0)
         {
            if(Boolean(_timeMC) && Boolean(_timeMC.parent))
            {
               _timeMC.parent.removeChild(_timeMC);
            }
            Tick.instance.removeRender(this.updateTimeMC);
            this.timeComplete();
         }
      }
      
      override protected function timeComplete() : void
      {
         super.timeComplete();
         ActCalendarConfig.setCurActIndex();
      }
      
      override protected function removeTimeComplete() : void
      {
         super.removeTimeComplete();
         if(_timeComplete)
         {
            _timeComplete = null;
            setShowTime(true,this.TIMER_SEC);
            showTime();
         }
         if(_timeMC)
         {
            _timeMC.visible = false;
         }
      }
   }
}
