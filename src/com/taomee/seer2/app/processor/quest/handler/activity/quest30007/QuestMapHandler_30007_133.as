package com.taomee.seer2.app.processor.quest.handler.activity.quest30007
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.constant.FunctionalityType;
   import com.taomee.seer2.app.dialog.events.FunctionalityBoxEvent;
   import com.taomee.seer2.app.dialog.functionality.CustomUnit;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.entity.definition.NpcDefinition;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_30007_133 extends QuestMapHandler
   {
       
      
      private var fala:MovieClip;
      
      private var falaDefin:NpcDefinition;
      
      private var questId:int;
      
      private var armBtn:SimpleButton;
      
      private var face1:MovieClip;
      
      private var face2:MovieClip;
      
      private var face3:MovieClip;
      
      private var toSceneId:int = 860;
      
      private var falaId:int = 478;
      
      public function QuestMapHandler_30007_133(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         this.questId = _quest.id;
         if(QuestManager.isCanAccepted(this.questId))
         {
            this.playStory();
         }
         if(QuestManager.isAccepted(this.questId) && !QuestManager.isStepComplete(this.questId,1))
         {
            this.initStep1();
         }
      }
      
      private function playStory() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30007_0"),function():void
         {
            fala = _processor.resLib.getMovieClip("Fala");
            fala.gotoAndStop("常态冒泡");
            fala.addEventListener(MouseEvent.CLICK,showFaDia);
            fala.buttonMode = true;
            _map.front.addChild(fala);
         });
      }
      
      private function showFaDia(param1:MouseEvent) : void
      {
         var _loc2_:XML = <npc id="478" resId="478" name="" dir="0" width="25" height="90" pos="439,426" actorPos="439,433" path="">
					<dialog npcId="478" npcName="嘴巴封住的法拉" transport="">
						<branch id="default">
							<node emotion="0"><![CDATA[……啊 啊……*%%*$!@@&*%*%&(%*(]]></node>
							<reply action="close"><![CDATA[打个酱油，路过此地！]]></reply>
						</branch>
					</dialog>
				</npc>;
         this.falaDefin = new NpcDefinition(_loc2_);
         DialogPanel.showForNpc(this.falaDefin);
         var _loc3_:CustomUnit = new CustomUnit(FunctionalityType.ACTIVE,"与神的对决","30007_0");
         _loc3_.addEventListener(FunctionalityBoxEvent.CUSTOM_UNIT_CLICK,this.onUnitClick);
         DialogPanel.functionalityBox.addUnit(_loc3_);
      }
      
      private function onUnitClick(param1:FunctionalityBoxEvent) : void
      {
         var event:FunctionalityBoxEvent = param1;
         this.fala.removeEventListener(MouseEvent.CLICK,this.showFaDia);
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30007_1"),function():void
         {
            NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"法拉法拉！他们到底怎么了？去那里了？什么阴谋？梦境的去处又是那里？"]],["会不会问太多啊"],[function():void
            {
               NpcDialog.show(falaId,"嘴巴封住的法拉",[[0,"（大哥、大姐）求拉掉嘴上的封带……"]],["点击法拉"],[function():void
               {
                  QuestManager.addEventListener(QuestEvent.ACCEPT,onAccept);
                  QuestManager.accept(questId);
               }]);
            }]);
         });
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         if(param1.questId == this.questId)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
            this.initStep1();
         }
      }
      
      private function initStep1() : void
      {
         if(!this.fala)
         {
            this.fala = _processor.resLib.getMovieClip("Fala");
            this.fala.buttonMode = true;
         }
         _map.front.addChild(this.fala);
         this.fala.addEventListener(MouseEvent.CLICK,this.showArmIcon);
      }
      
      private function showArmIcon(param1:MouseEvent) : void
      {
         this.fala.gotoAndStop("出现机械手臂");
         this.armBtn = this.fala["armBtn"];
         this.armBtn.addEventListener(MouseEvent.CLICK,this.clearSellotape);
         this.fala.removeEventListener(MouseEvent.CLICK,this.showArmIcon);
      }
      
      private function clearSellotape(param1:MouseEvent) : void
      {
         var animation:MovieClip;
         var event:MouseEvent = param1;
         this.armBtn.removeEventListener(MouseEvent.CLICK,this.clearSellotape);
         this.fala.gotoAndStop("撕掉封带动画");
         animation = this.fala["tearMc"];
         animation.stop();
         MovieClipUtil.playMc(animation,1,animation.totalFrames,function():void
         {
            NpcDialog.show(falaId,"嘴巴封住的法拉",[[0,"矮油我的妈呀！刚才可把我给吓死了！他应该是利用我进入了雷伊的梦境吧……"]],[" 逼于无奈了吓吓法拉！（点它）"],[function():void
            {
               fala.addEventListener(MouseEvent.CLICK,showSmile);
            }]);
         });
      }
      
      private function showSmile(param1:MouseEvent) : void
      {
         this.fala.gotoAndStop("3个ICON判断");
         this.fala.removeEventListener(MouseEvent.CLICK,this.showSmile);
         this.face1 = this.fala["Smile"];
         this.face1.addEventListener(MouseEvent.CLICK,this.chekFace);
         this.face2 = this.fala["Twat"];
         this.face2.addEventListener(MouseEvent.CLICK,this.chekFace);
         this.face3 = this.fala["Terror"];
         this.face3.addEventListener(MouseEvent.CLICK,this.chekFace);
         this.face1.gotoAndStop(1);
         this.face2.gotoAndStop(1);
         this.face3.gotoAndStop(1);
      }
      
      private function chekFace(param1:MouseEvent) : void
      {
         var mc:MovieClip;
         var event:MouseEvent = param1;
         this.face1.gotoAndStop(1);
         this.face2.gotoAndStop(1);
         mc = event.currentTarget as MovieClip;
         if(mc.totalFrames > 1)
         {
            mc.gotoAndStop(2);
         }
         else
         {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30007_2"),function():void
            {
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,completeStep1);
               QuestManager.completeStep(questId,1);
               face1.removeEventListener(MouseEvent.CLICK,chekFace);
               face2.removeEventListener(MouseEvent.CLICK,chekFace);
               face3.removeEventListener(MouseEvent.CLICK,chekFace);
            });
         }
      }
      
      private function completeStep1(param1:QuestEvent) : void
      {
         if(param1.questId == this.questId && param1.stepId == 1)
         {
            SceneManager.changeScene(SceneType.LOBBY,this.toSceneId);
         }
      }
      
      override public function processMapDispose() : void
      {
         if(this.fala)
         {
            this.fala.removeEventListener(MouseEvent.CLICK,this.showFaDia);
            this.fala.removeEventListener(MouseEvent.CLICK,this.showArmIcon);
            this.fala.removeEventListener(MouseEvent.CLICK,this.showSmile);
            _map.front.removeChild(this.fala);
         }
         if(this.armBtn)
         {
            this.armBtn.removeEventListener(MouseEvent.CLICK,this.clearSellotape);
         }
         if(this.face1)
         {
            this.face1.removeEventListener(MouseEvent.CLICK,this.chekFace);
            this.fala.removeChild(this.face1);
         }
         if(this.face2)
         {
            this.face2.removeEventListener(MouseEvent.CLICK,this.chekFace);
            this.fala.removeChild(this.face2);
         }
         if(this.face3)
         {
            this.face3.removeEventListener(MouseEvent.CLICK,this.chekFace);
            this.fala.removeChild(this.face3);
         }
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
      }
   }
}
