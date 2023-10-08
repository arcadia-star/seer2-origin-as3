package com.taomee.seer2.app.cmdl
{
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.core.net.MessageEvent;
   import flash.utils.IDataInput;
   import org.taomee.bean.BaseBean;
   
   public class SystemTipBean extends BaseBean
   {
       
      
      private const ALERT_BAR:String = "alertBar";
      
      private const FLOAT:String = "float";
      
      public function SystemTipBean()
      {
         super();
         Connection.addCommandListener(CommandSet.NONO_TIME_BUTLER_UPDATE_1197,this.onTip);
         finish();
      }
      
      private function onTip(param1:MessageEvent) : void
      {
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         this.setTipShow(_loc3_);
      }
      
      private function setTipShow(param1:uint) : void
      {
         switch(param1)
         {
            case 1:
               this.setTipStyle("给小精灵留点饭团吧，明天再来找他们打！");
               break;
            case 2:
               this.setTipStyle("布鲁托今天的饭团已经都给你啦，明天再来和他打吧！");
         }
      }
      
      private function setTipStyle(param1:String, param2:String = "float") : void
      {
         if(param2 == this.ALERT_BAR)
         {
            AlertManager.showAlert(param1);
         }
         else
         {
            ServerMessager.addMessage(param1);
         }
      }
   }
}
