package com.taomee.seer2.app.activity.processor.grassBlade
{
   import com.taomee.seer2.app.activity.processor.ActivityProcessor;
   import com.taomee.seer2.app.activity.processor.WaterGrassCSE;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   
   public class ChrismasSpecialGrassEvent extends WaterGrassCSE
   {
      
      private static const BOSS_ID:uint = 43;
       
      
      public function ChrismasSpecialGrassEvent(param1:uint, param2:ActivityProcessor)
      {
         super(param1,param2);
      }
      
      override protected function showDialog() : void
      {
         NpcDialog.show(32,"萨伦帝国士官",[[0,"这也太厉害了，我这次状态不好，你给我等着，下次我一定会带上我最厉害的精灵再回来的！"]],["喂！你的精灵怎么办？"],[function():void
         {
            NpcDialog.show(455,"硬壳独角",[[0,"\t我的主人离我而去了！我可不愿意在这里做一只野生精灵，如果你有做我主人实力的话就证明看看！"]],["我会证明的！","我还没准备好！"],[function():void
            {
               FightManager.startFightWithWild(BOSS_ID);
            },null]);
         }]);
      }
   }
}
