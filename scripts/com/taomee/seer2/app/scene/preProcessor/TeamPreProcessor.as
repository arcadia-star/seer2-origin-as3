package com.taomee.seer2.app.scene.preProcessor
{
   import com.taomee.seer2.core.scene.SwitchData;
   import com.taomee.seer2.core.scene.SwitchPreProcessor;
   
   public class TeamPreProcessor extends SwitchPreProcessor
   {
       
      
      public function TeamPreProcessor()
      {
         super();
      }
      
      override public function process(param1:SwitchData, param2:Function) : void
      {
         _data = param1;
         _callBack = param2;
         _data.resourceId = 60000;
         handlerCallBack();
      }
   }
}
