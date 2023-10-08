package com.taomee.seer2.app.activity.processor
{
   import com.taomee.seer2.app.activity.data.ActivityDefinition;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.ui.ButtonPanelData;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1140;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   
   public class FlySeriesFight extends ActivityProcessor
   {
      
      private static const NORMAL_FIGHT_INDEX:uint = 50;
      
      private static const SPECIAL_FIGHT_INDEX:uint = 51;
      
      private static const DUALPET_FIGHT_INDEX:uint = 56;
      
      private static const DUALPET_SUPER_FIGHT_INDEX:uint = 1833;
      
      private static const EVENT_ID:uint = 14;
       
      
      private var _map:MapModel;
      
      private var _sceneAnimation:MovieClip;
      
      private var _isDualPet:Boolean;
      
      private var _isSuper:Boolean;
      
      public function FlySeriesFight(param1:ActivityDefinition)
      {
         super(param1);
      }
      
      override public function start() : void
      {
         this.initEventListener();
         super.start();
      }
      
      override protected function onMapStart(param1:SceneEvent) : void
      {
         this.clearScene();
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onActivityUnitClick);
      }
      
      override protected function onMapComplete(param1:SceneEvent) : void
      {
         var btnData:ButtonPanelData = null;
         var evt:SceneEvent = param1;
         if(Boolean(SceneManager.active) && SceneManager.active.mapID == 770)
         {
            btnData = new ButtonPanelData();
            btnData.catchEnabled = false;
            if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord && FightManager.currentFightRecord.initData && FightManager.currentFightRecord.initData.positionIndex && FightManager.currentFightRecord.initData.positionIndex == NORMAL_FIGHT_INDEX && FightManager.fightWinnerSide != FightSide.LEFT)
            {
               NpcDialog.show(80,"葛蕾芬兵团长",[[3,"放弃吧！葛蕾芬兵团是不可战胜的！"]],["哎……那我还是走了","继续挑战！"],[null,function():void
               {
                  FightManager.startFightWithWild(NORMAL_FIGHT_INDEX,null,null,btnData);
               }]);
            }
            else if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord && FightManager.currentFightRecord.initData && FightManager.currentFightRecord.initData.positionIndex && FightManager.currentFightRecord.initData.positionIndex == DUALPET_FIGHT_INDEX && FightManager.fightWinnerSide != FightSide.LEFT)
            {
               NpcDialog.show(80,"葛蕾芬兵团长",[[3,"再来多少次结果都是一样的！"]],["哎……那我还是走了","继续挑战！"],[null,function():void
               {
                  FightManager.startFightBinaryWild(DUALPET_FIGHT_INDEX,null,null,btnData);
               }]);
            }
            this._map = SceneManager.active.mapModel;
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onActivityUnitClick);
         }
      }
      
      private function initEventListener() : void
      {
         Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140,this.onEventStart);
      }
      
      private function onEventStart(param1:MessageEvent) : void
      {
         var evt:MessageEvent = param1;
         var parser:Parser_1140 = new Parser_1140(evt.message.getRawDataCopy());
         if(parser.id == EVENT_ID && parser.index == 14)
         {
            NpcDialog.show(461,"受伤的葛蕾芬",[[0,"我的出生就是为葛蕾芬兵团获取胜利的荣光！既然不能完成这个使命……那就杀了我吧！"]],["杀戮不能解决任何问题！"],[function():void
            {
               NpcDialog.show(461,"受伤的葛蕾芬",[[0,"你难道不想杀了我？只要我复原了，还是会继续与你对战！"]],["我欣赏你的实力！成为我的伙伴吧！"],[function():void
               {
                  FightManager.startFightWithWild(SPECIAL_FIGHT_INDEX);
               }]);
            }]);
         }
      }
      
      private function onActivityUnitClick(param1:DialogPanelEvent) : void
      {
         var evt:DialogPanelEvent = param1;
         if((evt.content as DialogPanelEventData).params == "fight_single_npc_770")
         {
            NpcDialog.show(80,"葛蕾芬兵团长",[[3,"飞翼氏族与地面各部族早已没有任何联系！请不要做无望的挣扎！"]],["我不是坏人……我为和平而来……"],[function():void
            {
               NpcDialog.show(80,"葛蕾芬兵团长",[[3,"葛蕾芬兵团……出击！！"]],["那么凶……还是撤退吧！","那就打打看咯！"],[null,function():void
               {
                  _isDualPet = false;
                  playSceneAnimation();
               }]);
            }]);
         }
         else if((evt.content as DialogPanelEventData).params == "fight_dual_npc_770")
         {
            NpcDialog.show(80,"葛蕾芬兵团长",[[3,"双精灵？呵呵……受过统一军事化训练的葛蕾芬兵团不会出任何差池。你是想挨打……还是想挨打？"]],["我不想挨打……","不试试看怎么知道！"],[null,function():void
            {
               _isDualPet = true;
               playSceneAnimation();
            }]);
         }
         else if((evt.content as DialogPanelEventData).params == "fight_super_dual_npc_770")
         {
            NpcDialog.show(80,"葛蕾芬兵团长",[[0,"好久不见了，强大的星际使者。你是来寻求挑战的吗？"]],["......"],[function():void
            {
               NpcDialog.show(400,"小赛尔",[[0,"啊……好久不见（葛蕾芬兵团长还是这么咄咄逼人）"]],["......"],[function():void
               {
                  NpcDialog.show(80,"葛蕾芬兵团长",[[0,"撒莱尔，自从你去过斯坦因的研究所，里面的那个小家伙就像解放了一样，每天在族里飞来飞去，大家都很喜欢他呢。"]],["........."],[function():void
                  {
                     NpcDialog.show(400,"小赛尔",[[0,"是嘛，她也算完成任务了，放下重担开心生活了吧（没想到她居然会被萌物萌到……！）~"]],["......"],[function():void
                     {
                        NpcDialog.show(80,"葛蕾芬兵团长",[[0,"葛蕾芬兵团长：你在找她的踪迹吗？我可以告诉你哦，不过先要看看你的实力才行。"]],["......"],[function():void
                        {
                           NpcDialog.show(400,"小赛尔",[[3,"（果然还是变成这样子了，唉）那好吧……得罪啦！"]],["我不想挨打……","挑战葛蕾芬兵团！"],[null,function():void
                           {
                              _isSuper = true;
                              playSceneAnimation();
                           }]);
                        }]);
                     }]);
                  }]);
               }]);
            }]);
         }
      }
      
      private function playSceneAnimation() : void
      {
         if(this._sceneAnimation == null)
         {
            QueueLoader.load(URLUtil.getActivityAnimation("flySeriesFight/1"),LoadType.SWF,this.onSceneAnimationLoaded);
         }
         else
         {
            this.showSceneAnimation();
         }
      }
      
      private function onSceneAnimationLoaded(param1:ContentInfo) : void
      {
         this._sceneAnimation = (param1.content as MovieClip)["soldiers"];
         this.showSceneAnimation();
      }
      
      private function showSceneAnimation() : void
      {
         this._map.front.addChild(this._sceneAnimation);
         MovieClipUtil.playMc(this._sceneAnimation,1,this._sceneAnimation.totalFrames,function():void
         {
            startFightAfterAnimation();
         },true);
      }
      
      private function startFightAfterAnimation() : void
      {
         var _loc1_:ButtonPanelData = new ButtonPanelData();
         _loc1_.catchEnabled = false;
         if(this._isDualPet)
         {
            FightManager.startFightBinaryWild(DUALPET_FIGHT_INDEX,null,null,_loc1_);
         }
         else if(this._isSuper)
         {
            FightManager.startFightBinaryWild(DUALPET_SUPER_FIGHT_INDEX,null,null,_loc1_);
         }
         else
         {
            FightManager.startFightWithWild(NORMAL_FIGHT_INDEX,null,null,_loc1_);
         }
         this._isDualPet = false;
         this._isSuper = false;
      }
      
      private function clearScene() : void
      {
         QueueLoader.cancel(URLUtil.getActivityAnimation("flySeriesFight/1"),this.onSceneAnimationLoaded);
         if(this._sceneAnimation)
         {
            DisplayObjectUtil.removeFromParent(this._sceneAnimation);
            this._sceneAnimation = null;
         }
         this._map = null;
      }
      
      override public function refresh() : void
      {
      }
      
      override public function dispose() : void
      {
         this.clearScene();
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onActivityUnitClick);
         Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140,this.onEventStart);
         super.dispose();
      }
   }
}
