package com.taomee.seer2.app.activity.processor
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1140;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   
   public class FlameBattleCSE
   {
      
      private static const SPECIAL_FIGHT_INDEX:uint = 64;
       
      
      protected var _eventId:uint;
      
      private var _processor:ActivityProcessor;
      
      public function FlameBattleCSE(param1:uint, param2:ActivityProcessor)
      {
         super();
         this._processor = param2;
         this._eventId = param1;
         Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140,this.onEventStart);
      }
      
      private function onEventStart(param1:MessageEvent) : void
      {
         var evt:MessageEvent = param1;
         var parser:Parser_1140 = new Parser_1140(evt.message.getRawDataCopy());
         if(parser.index == this._eventId && parser.id == this._eventId)
         {
            if(SceneManager.prevSceneType == SceneType.ARENA)
            {
               NpcDialog.show(467,"凯瑟琳",[[0,"{$name}， 你这家伙好像还挺厉害的吗？要不要来和我比试下看看？"]],["什么的东西！"],[function():void
               {
                  NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"喂！你是哪里来的？刚才还没看到呢！好烫啊！难道是躲在火山里的稀有精灵！"]],["仔细观察"],[function():void
                  {
                     NpcDialog.show(467,"凯瑟琳",[[0,"别废话了！我可不是那些好欺负的精灵，你到底准备好了没有啊？"]],["我准备好了！","我还没准备好！"],[function():void
                     {
                        FightManager.startFightWithWild(SPECIAL_FIGHT_INDEX);
                     }]);
                  }]);
               }]);
            }
         }
      }
      
      public function dispose() : void
      {
         Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140,this.onEventStart);
      }
   }
}
