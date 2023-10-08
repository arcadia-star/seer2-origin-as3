package com.taomee.seer2.app.newGuidStatistics
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.newPlayerGuideVerOne.NewPlayerGuideTimeManager;
   import com.taomee.seer2.core.manager.TimeManager;
   
   public class NewGuidStatisManager
   {
       
      
      public function NewGuidStatisManager()
      {
         super();
      }
      
      public static function statisHandle(param1:int) : void
      {
         var _loc2_:Date = new Date(ActorManager.actorInfo.createTime * 1000);
         var _loc3_:Date = new Date(TimeManager.getPrecisionServerTime() * 1000);
         if(!(_loc2_.fullYear == _loc3_.fullYear && _loc2_.month == _loc3_.month && _loc2_.date == _loc3_.date))
         {
            return;
         }
         switch(param1)
         {
            case 10:
               StatisticsManager.newSendNovice("新手引导","新手引导","完成战斗1");
               break;
            case 11:
               StatisticsManager.newSendNovice("新手引导","新手引导","打开30日奖励面板");
               break;
            case 12:
               StatisticsManager.newSendNovice("新手引导","新手引导","点击领取奖励");
               break;
            case 13:
               StatisticsManager.newSendNovice("新手引导","新手引导","打开拉奥叶装置试炼1");
               break;
            case 14:
               StatisticsManager.newSendNovice("新手引导","新手引导","点击试炼1去完成");
               break;
            case 9:
               StatisticsManager.newSendNovice("新手引导","新手引导","战斗中点击技能1");
               break;
            case 8:
               StatisticsManager.newSendNovice("新手引导","新手引导","点击完成试炼1");
               break;
            case 15:
               StatisticsManager.newSendNovice("新手引导","新手引导","打开拉奥叶装置试炼2");
               break;
            case 16:
               StatisticsManager.newSendNovice("新手引导","新手引导","点击试炼2去完成");
               break;
            case 18:
               StatisticsManager.newSendNovice("新手引导","新手引导","点击完成试炼2");
               break;
            case 19:
               StatisticsManager.newSendNovice("新手引导","新手引导","打开拉奥叶装置试炼3");
               break;
            case 20:
               StatisticsManager.newSendNovice("新手引导","新手引导","点击试炼3去完成");
               break;
            case 21:
               StatisticsManager.newSendNovice("新手引导","新手引导","完成试炼3战斗");
               break;
            case 22:
               StatisticsManager.newSendNovice("新手引导","新手引导","点击孵化对话下一步");
               break;
            case 23:
               StatisticsManager.newSendNovice("新手引导","新手引导","点击精元孵化器");
               break;
            case 6:
               StatisticsManager.newSendNovice("新手引导","新手引导","完成试炼3");
               break;
            case 24:
               StatisticsManager.newSendNovice("新手引导","新手引导","打开迪兰特装置试炼4");
               break;
            case 7:
               StatisticsManager.newSendNovice("新手引导","新手引导","点击试炼4去完成");
               break;
            case 25:
               StatisticsManager.newSendNovice("新手引导","新手引导","点击大地图");
               break;
            case 26:
               StatisticsManager.newSendNovice("新手引导","新手引导","点击商店");
               break;
            case 27:
               StatisticsManager.newSendNovice("新手引导","新手引导","完成试炼4");
               break;
            case 28:
               StatisticsManager.newSendNovice("新手引导","新手引导","打开迪兰特装置试炼5");
               break;
            case 29:
               StatisticsManager.newSendNovice("新手引导","新手引导","点击试炼5去完成");
               break;
            case 30:
               StatisticsManager.newSendNovice("新手引导","新手引导","完成试炼5");
               break;
            case 31:
               StatisticsManager.newSendNovice("新手引导","新手引导","打开迪兰特装置试炼6");
               break;
            case 32:
               StatisticsManager.newSendNovice("新手引导","新手引导","点击试炼6去完成");
               break;
            case 33:
               StatisticsManager.newSendNovice("新手引导","新手引导","完成试炼6");
               break;
            case 34:
               StatisticsManager.newSendNovice("新手引导","新手引导","打开修罗斯装置试炼7");
               break;
            case 35:
               StatisticsManager.newSendNovice("新手引导","新手引导","点击试炼7去完成");
               break;
            case 36:
               StatisticsManager.newSendNovice("新手引导","新手引导","完成试炼7");
               break;
            case 39:
               StatisticsManager.newSendNovice("新手引导","新手引导","点击修罗斯装置试炼8");
               break;
            case 40:
               StatisticsManager.newSendNovice("新手引导","新手引导","点击试炼8去完成");
               break;
            case 41:
               StatisticsManager.newSendNovice("新手引导","新手引导","打开精灵背包");
               break;
            case 42:
               StatisticsManager.newSendNovice("新手引导","新手引导","点击强化资质");
               break;
            case 43:
               StatisticsManager.newSendNovice("新手引导","新手引导","完成试炼8");
               break;
            case 44:
               StatisticsManager.newSendNovice("新手引导","新手引导","打开修罗斯装置试炼9");
               break;
            case 45:
               StatisticsManager.newSendNovice("新手引导","新手引导","点击试炼9去完成");
               break;
            case 46:
               StatisticsManager.newSendNovice("新手引导","新手引导","点击升级礼包");
               break;
            case 47:
               StatisticsManager.newSendNovice("新手引导","新手引导","完成试炼9");
         }
      }
      
      public static function newPlayerStatisHandle(param1:int) : void
      {
         if(!NewPlayerGuideTimeManager.timeCheckNewGuide())
         {
            return;
         }
         switch(param1)
         {
            case 1:
               StatisticsManager.newSendNovice("2015年11月新手改版","2015年11月新手改版","进入新手场景人数");
               break;
            case 2:
               StatisticsManager.newSendNovice("2015年11月新手改版","2015年11月新手改版","你好小赛尔");
               break;
            case 3:
               StatisticsManager.newSendNovice("2015年11月新手改版","2015年11月新手改版","欢迎来到赛尔号2");
               break;
            case 4:
               StatisticsManager.newSendNovice("2015年11月新手改版","2015年11月新手改版","获得小梦");
               break;
            case 5:
               StatisticsManager.newSendNovice("2015年11月新手改版","2015年11月新手改版","点击试炼任务装置");
               break;
            case 6:
               StatisticsManager.newSendNovice("2015年11月新手改版","2015年11月新手改版","完成任务1");
               break;
            case 7:
               StatisticsManager.newSendNovice("2015年11月新手改版","2015年11月新手改版","完成任务2");
               break;
            case 8:
               StatisticsManager.newSendNovice("2015年11月新手改版","2015年11月新手改版","完成任务3");
               break;
            case 9:
               StatisticsManager.newSendNovice("2015年11月新手改版","2015年11月新手改版","完成任务4");
               break;
            case 10:
               StatisticsManager.newSendNovice("2015年11月新手改版","2015年11月新手改版","完成任务5");
               break;
            case 11:
               StatisticsManager.newSendNovice("2015年11月新手改版","2015年11月新手改版","完成任务6");
               break;
            case 12:
               StatisticsManager.newSendNovice("2015年11月新手改版","2015年11月新手改版","完成任务7");
               break;
            case 13:
               StatisticsManager.newSendNovice("2015年11月新手改版","2015年11月新手改版","自动弹出我要变强");
               break;
            case 14:
               StatisticsManager.newSendNovice("2015年11月新手改版","2015年11月新手改版","打开超进化之路面板");
               break;
            case 15:
               StatisticsManager.newSendNovice("2015年11月新手改版","2015年11月新手改版","主ICON40号点击");
               break;
            case 16:
               StatisticsManager.newSendNovice("2015年11月新手改版","2015年11月新手改版","主ICON41号点击");
         }
      }
   }
}
