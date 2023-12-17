package com.taomee.seer2.app.actives
{
   import com.taomee.seer2.app.animationInteractive.KeepBalance;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.sound.SoundManager;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class ActiveProcess_2 extends BaseActiveProcess
   {
       
      
      private var _keepBalance:KeepBalance;
      
      public function ActiveProcess_2()
      {
         super();
      }
      
      override public function start() : void
      {
         this._keepBalance = new KeepBalance(120,0);
         if(VipManager.vipInfo.vipFlag == 0)
         {
            NpcDialog.show(47,"安尼",[[4,"欢迎来帮忙！如果你干得很好的话，在11月11日-11月17日，VIP乐园试运营期间，你可以免费来玩！"]],["真的？太好了！"],[function():void
            {
               NpcDialog.show(47,"安尼",[[4,"当然！现在，我给你讲讲工作内容。你需要帮我们拉乐园外围的绳子，越直越好！直线超过120米，你就获得试玩资格啦！"]],["好的，开始吧！","哦，我过会儿再来帮你！"],[function():void
               {
                  playBalance();
               },null]);
            }]);
         }
         else
         {
            NpcDialog.show(47,"安尼",[[4,"嗨~~~又见到你很高兴！如果有空的话，再来帮帮忙吧？"]],["好的，我就是来帮忙的。","呵呵，我一会儿再来。"],[function():void
            {
               playBalance();
            },null]);
         }
      }
      
      private function playBalance() : void
      {
         this._keepBalance.setup("keepBalance_1",this.onKeepBalance);
         SoundManager.enabled = false;
         SoundManager.play(URLUtil.getGameSound(8),1,true);
      }
      
      private function onKeepBalance(param1:int) : void
      {
         var count:int = param1;
         SoundManager.stop(URLUtil.getGameSound(8));
         SoundManager.enabled = true;
         if(VipManager.vipInfo.vipFlag == 0)
         {
            if(count < 120)
            {
               NpcDialog.show(47,"安尼",[[4,"谢谢你的帮忙！不过，有点遗憾，你没有超过120米。呵呵，如果你有空的话，可以继续给我帮助。"]],["呵呵，好的。"],[function():void
               {
                  getItemFromServer(count);
               }]);
            }
            else
            {
               NpcDialog.show(47,"安尼",[[4,"嗨，你干得真不错。恭喜你获得了VIP试玩资格。记得11月11日-11月17日来VIP乐园玩哦！"]],["嗯！谢谢，再见！"],[function():void
               {
                  getItemFromServer(count);
               }]);
            }
         }
         else
         {
            NpcDialog.show(47,"安尼",[[4,"噢！谢谢你！希望VIP乐园早点完工，再见！"]],[" 再见！"],[function():void
            {
               getItemFromServer(count);
            }]);
         }
      }
      
      private function getItemFromServer(param1:int) : void
      {
         if(param1 > 120)
         {
            return;
         }
         Connection.addCommandListener(CommandSet.GET_VIP_TRY_1134,this.onGetItem);
         Connection.send(CommandSet.GET_VIP_TRY_1134,param1);
      }
      
      private function onGetItem(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.GET_VIP_TRY_1134,this.onGetItem);
         var _loc2_:uint = uint(param1.message.getRawDataCopy().readUnsignedByte());
         if(_loc2_ == 1)
         {
            VipManager.vipInfo.vipFlag = 2;
         }
      }
   }
}
