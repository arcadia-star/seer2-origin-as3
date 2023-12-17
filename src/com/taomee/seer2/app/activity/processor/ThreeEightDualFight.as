package com.taomee.seer2.app.activity.processor
{
   import com.taomee.seer2.app.activity.data.ActivityDefinition;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1140;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class ThreeEightDualFight extends ActivityProcessor
   {
       
      
      public function ThreeEightDualFight(param1:ActivityDefinition)
      {
         _relatedMapIDArr = [310,780];
         super(param1);
      }
      
      override public function start() : void
      {
         super.start();
         Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140,this.onEvent);
      }
      
      private function onEvent(param1:MessageEvent) : void
      {
         var _loc2_:Parser_1140 = new Parser_1140(param1.message.getRawDataCopy());
         if(_loc2_.flag == 0 && _loc2_.index == 15)
         {
            ModuleManager.showModule(URLUtil.getAppModule("ThreeEightRewardPanel"),"正在打开刮奖面板……",{
               "id":_loc2_.id,
               "count":_loc2_.count
            });
         }
      }
      
      override public function dispose() : void
      {
         Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140,this.onEvent);
         super.dispose();
      }
   }
}
