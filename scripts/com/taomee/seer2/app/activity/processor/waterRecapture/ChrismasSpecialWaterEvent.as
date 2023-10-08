package com.taomee.seer2.app.activity.processor.waterRecapture
{
   import com.taomee.seer2.app.activity.processor.ActivityProcessor;
   import com.taomee.seer2.app.activity.processor.WaterGrassCSE;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   
   public class ChrismasSpecialWaterEvent extends WaterGrassCSE
   {
      
      private static const BOSS_ID:uint = 44;
       
      
      public function ChrismasSpecialWaterEvent(param1:uint, param2:ActivityProcessor)
      {
         super(param1,param2);
      }
      
      override protected function showDialog() : void
      {
         NpcDialog.show(40,"萨伦帝国士官",[[0,"别以为你就这样赢了哦，缇娜女士是不会放过你的！我们下次再战吧！"]],["喂！你的精灵怎么办？"],[function():void
         {
            NpcDialog.show(456,"巴图",[[0,"（抽泣~抽泣）我的主人不要我了！都是你害的！我要和你拼命！"]],["捕获它","先走为妙！"],[function():void
            {
               FightManager.startFightWithWild(BOSS_ID);
            },null]);
         }]);
      }
   }
}
