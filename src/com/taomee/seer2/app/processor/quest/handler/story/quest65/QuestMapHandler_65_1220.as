package com.taomee.seer2.app.processor.quest.handler.story.quest65
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.pet.events.PetInfoEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.InProgressMark;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_65_1220 extends QuestMapHandler
   {
      
      private static var isFight:Boolean = false;
       
      
      private var _mc:MovieClip;
      
      private var _accept:InProgressMark;
      
      public function QuestMapHandler_65_1220(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(SceneManager.prevSceneType == SceneType.ARENA && isFight)
         {
            isFight = false;
            if(FightManager.fightWinnerSide == FightSide.LEFT)
            {
               this.win();
            }
            else
            {
               this.noWin();
            }
            return;
         }
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this._mc = _processor.resLib.getMovieClip("mc1");
            _map.content.addChild(this._mc);
            this._mc.buttonMode = true;
            this._mc.addEventListener(MouseEvent.CLICK,this.onMc);
            this._accept = new InProgressMark();
            this._accept.x = 700;
            this._accept.y = 394;
            _map.content.addChild(this._accept);
         }
      }
      
      private function win() : void
      {
         NpcDialog.show(316,"匹喏曹",[[1,"真感谢你救了我，谢谢你。"]],["看来你是好人"],[function():void
         {
            NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"这是一个什么东西，真恐怖。"]],["它怎么回来袭击我们"],[function():void
            {
               NpcDialog.show(316,"匹喏曹",[[0,"它是守护整个虫群氏族的SPT。它只听得见召唤它的声音，其它的它都视而不见。"]],["召唤它的东西？"],[function():void
               {
                  NpcDialog.show(316,"匹喏曹",[[0,"是的，召唤它的是一个叫迷笛的笛子，声音奇特，它听见了之后就会立马赶到吹笛子人的身边。"]],["很神奇"],[function():void
                  {
                     NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"也就是说刚才有人吹响了迷笛？"]],["人在哪里？"],[function():void
                     {
                        NpcDialog.show(316,"匹喏曹",[[4,"不知道，不管他，反正我们都安然无恙了，它也不敢再来了，看来你们都是好人，那我告诉你白雪公主的故事吧。"]],["仔细听"],[function():void
                        {
                           MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("65_0"),3,[[1,0]],function():void
                           {
                              NpcDialog.show(316,"匹喏曹",[[3,"可恶的黑桃皇后，他陷害公主，她就是为了让整个氏族都变成她的爪牙，真正掌控整个氏族。"]],["愤怒！"],[function():void
                              {
                                 NpcDialog.show(316,"匹喏曹",[[0,"而这个时候对她威胁最大的就是白雪公主，她必须彻底除掉这个公主才能安心的当上她皇后的梦想。于是现在开始下令诛杀她。"]],["你们相信我"],[function():void
                                 {
                                    NpcDialog.show(10,"巴蒂",[[0,"我想大家都在空口无凭的说，我们应该见见白雪公主才对。"]],["能带我们见她吗？"],[function():void
                                    {
                                       NpcDialog.show(316,"匹喏曹",[[0,"那……你们跟着我吧。"]],["一起走吧……"],[function():void
                                       {
                                          QuestManager.completeStep(_quest.id,1);
                                       }]);
                                    }]);
                                 }]);
                              }]);
                           });
                        }]);
                     }]);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function noWin() : void
      {
         this._mc = _processor.resLib.getMovieClip("mc1");
         _map.content.addChild(this._mc);
         this._mc.buttonMode = true;
         this._mc.addEventListener(MouseEvent.CLICK,this.onMc);
         this._accept = new InProgressMark();
         this._accept.x = 503;
         this._accept.y = 274;
         _map.content.addChild(this._accept);
         NpcDialog.show(316,"匹喏曹",[[3,"快去打它，一定要打赢它！"]],["这就去","先休息一会"],[function():void
         {
            Connection.addCommandListener(CommandSet.TREAT_ALL_PET_1215,onAddAllPetBlood);
            Connection.send(CommandSet.TREAT_ALL_PET_1215);
         }]);
      }
      
      private function onAddAllPetBlood(param1:MessageEvent) : void
      {
         var _loc3_:PetInfo = null;
         var _loc4_:int = 0;
         Connection.removeCommandListener(CommandSet.TREAT_ALL_PET_1215,this.onAddAllPetBlood);
         var _loc2_:Vector.<PetInfo> = PetInfoManager.getAllBagPetInfo();
         for each(_loc3_ in _loc2_)
         {
            _loc3_.hp = _loc3_.maxHp;
            PetInfoManager.dispatchEvent(PetInfoEvent.PET_PROPERTIES_CHANGE,_loc3_);
         }
         _loc4_ = int(param1.message.getRawData().readUnsignedInt());
         ActorManager.actorInfo.coins = _loc4_;
         isFight = true;
         FightManager.startFightWithWild(443);
      }
      
      private function onMc(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("65_1"),function():void
         {
            NpcDialog.show(316,"匹喏曹",[[3,"可恶的特米提，你已经不听使唤了，快帮我击败它！"]],["挑战特米提"],[function():void
            {
               isFight = true;
               FightManager.startFightWithWild(443);
            }]);
         },true,false,2);
      }
      
      override public function processMapDispose() : void
      {
         if(this._mc)
         {
            this._mc.removeEventListener(MouseEvent.CLICK,this.onMc);
         }
         DisplayUtil.removeForParent(this._mc);
         if(this._accept)
         {
            DisplayUtil.removeForParent(this._accept);
         }
         Connection.removeCommandListener(CommandSet.TREAT_ALL_PET_1215,this.onAddAllPetBlood);
      }
   }
}
