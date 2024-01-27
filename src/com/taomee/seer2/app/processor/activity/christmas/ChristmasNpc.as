package com.taomee.seer2.app.processor.activity.christmas {
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.definition.NpcDefinition;

public class ChristmasNpc {


    private var _npc:Mobile;

    public function ChristmasNpc(param1:int) {
        super();
        this.init(param1);
    }

    private function init(param1:int):void {
        var _loc2_:XML = null;
        var _loc3_:NpcDefinition = null;
        switch (param1) {
            case 1:
                _loc2_ = <npc id="436" resId="436" name="" dir="1" width="25" height="50" pos="376,434"
                              actorPos="388,450" path="">
                    <dialog npcId="436" npcName="砂砂" transport="">
                        <branch id="default" npcId="436" npcName="砂砂">
                            <node emotion="0"><![CDATA[拳头克剪子，剪子克布，布，布克……剪子？？]]></node>
                            <reply action="close"><![CDATA[布克拳头啦！]]></reply>
                        </branch>
                    </dialog>
                    <eventHandler>
                        <mouseOver>
                            <HandlerShowNpcSlogan><![CDATA[烦躁！烦躁！我到底会不会是圣诞代言人？]]></HandlerShowNpcSlogan>
                        </mouseOver>
                    </eventHandler>
                </npc>;
                break;
            case 2:
                _loc2_ = <npc id="436" resId="436" name="" dir="1" width="25" height="50" pos="376,434"
                              actorPos="388,450" path="">
                    <dialog npcId="436" npcName="砂砂" transport="">
                        <branch id="default" npcId="436" npcName="砂砂">
                            <node emotion="0"><![CDATA[拳头克剪子，剪子克布，布，布克……剪子？？]]></node>
                            <reply action="close"><![CDATA[布克拳头啦！]]></reply>
                        </branch>
                    </dialog>
                    <eventHandler>
                        <mouseOver>
                            <HandlerShowNpcSlogan><![CDATA[烦躁！烦躁！我到底会不会是圣诞代言人？]]></HandlerShowNpcSlogan>
                        </mouseOver>
                    </eventHandler>
                </npc>;
        }
    }

    public function getNpc():Mobile {
        return this._npc;
    }
}
}
