"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.tests = {
    'should parse qualified import': {
        input: "{% import * as lib from \"path/to/libs\" %}"
    },
    'should parse named import': {
        input: "{% import (B) from \"path/to/a/b\" %}"
    },
    'should parse a self closing tag': {
        input: '<simple/>'
    },
    'should parse a self closing tag with attributes 0': {
        input: '<user name="xyaa aaz" position={{4|x(20)}} wml:val="test"/>',
    },
    'should parse a self closing tag with attributes 1': {
        input: '<user app:enabled id=24 />',
    },
    'should parse a self closing tag with attributes 2': {
        input: '<user name="xyaa aaz" id="24" align="left"/>',
    },
    'should parse a parent tag': {
        input: '<panel>  \n\n\n\n\n\n\n\n\n  </panel>'
    },
    'should parse a parent tag with attributes': {
        input: '<panel type="default" size="40" align="left"> </panel>'
    },
    'should parse parent tags with mixed children': {
        input: '<panel> This is my offsprings.<a>Link</a>Hey now! <Input/></panel>'
    },
    'should parse parent tags with tag children (L1)': {
        input: '<panel><a></a></panel>'
    },
    'should parse parent tags with tag children (L2)': {
        input: '<panel><a href="link" onclick={{@someting.invoke()}}>' +
            'Click Here</a><table/></panel>'
    },
    'should parse parent tags with tag children (L3)': {
        input: '<panel><a href="link">Click Here</a><table/>' +
            '<panel c="22"></panel></panel>'
    },
    'should do it all together now': {
        input: '<modal name="mymodal" x="1" y="2">' +
            '<modal-header>My Modal</modal-header>' +
            '<modal-body>' +
            'Creativxity is inhibxited by greed and corruption.' +
            '<vote-button/>' +
            '<vote-count source={{@}}/> Votes' +
            '<textarea wml:id="ta" disabled size=32 onchange={{@setText}}>' +
            ' Various text' +
            '</textarea>' +
            '</modal-body>' +
            '</modal>'
    },
    'should parse for in expressions': {
        input: '<root>' +
            '{% for value,key in [] %}' +
            '<stem>{{value}}</stem>' +
            '{% endfor %}' +
            '</root>'
    },
    'should parse for of expressions': {
        input: '<root>' +
            '{% for value,key in list %}' +
            '<stem>{{key}} => {{value}}</stem>' +
            '{% endfor %}' +
            '</root>'
    },
    'should parse if then expressions': {
        input: '<Html id={{@id}}>{{ if @check() then a else b }}</Html>'
    },
    'should parse function expressions': {
        input: '<button onclick={{\\e ->call(e)}}/>'
    },
    'should parse calls': {
        input: '<tr>{% for x,i in y %} {{ f(x)(i) }} {% endfor %} </tr>'
    },
    'should parse negative numbers': {
        input: '<tag n={{ ( -0.5 + 3) }} m={{(4 + -2)}} g={{ (10 --5) }}/>'
    },
    'should allow filter chaining': {
        input: '<p>{{ @value | f1 | f2(2) | f3(@value) }}</p>'
    },
    'should parse if else statements': {
        input: '<Tag>{% if value %}<text>Text</text>{% else %}<text>else</text>{% endif %}</Tag>'
    },
    'should parse if else if statements': {
        input: "\n        <Tag>\n          {% if value %}\n            <text>Text</text>\n          {% else if value %} \n            <text>else</text> \n          {% else %} \n            no \n          {% endif %}\n        </Tag>"
    },
    'should parse short fun statements': {
        input: '{% fun vue () = <View/> %}'
    },
    'should parse short fun statements with arguments': {
        input: '{% fun vue (a:String) (b:String) (c:String) = ' +
            '<View a={{a}} b={{b}} c={{c}}/> %}'
    },
    'should parse short fun statements with type classes': {
        input: '{% fun vue [A,B:C,C] (a:A) (b:B) = ' +
            '{{ (a + b) + c }} %}'
    },
    'should parse extended fun statements': {
        input: '{% fun vue () %} <View/> {% endfun %}'
    },
    'should parse extended fun statements with arguments': {
        input: '{% fun vue (a:String) (b:String) (c:String) %}' +
            '<View a={{a}} b={{b}} c={{c}}/> {% endfun %}'
    },
    'should parse extended fun statements with type classes': {
        input: '{% fun vue [A,B:C,C] (a:A) (b:B) %} {{ ((a + b) + c) }} {% endfun %}'
    },
    'should parse binary expressions': {
        input: '<p>{{(Styles.A  + Styles.B)}}</p>'
    },
    'should parse complicated expressions': {
        input: '<div class={{((Styles.A + " ") + Style.B)}}/>'
    },
    'should allow for statement as child of fun': {
        input: '{% fun sven () %} {% for a in b %} {{b}} {% endfor %} {% endfun %}'
    },
    'should allow if statement as child of  fun': {
        input: '{% fun ate (o:Object) %} {% if a %} {{a}} {% else %} {{a}} ' +
            '{% endif %} {% endfun %}'
    },
    'should allow for booleans in interpolations': {
        input: '<bool active={{true}}>{{if fun() then false else true}}</bool>'
    },
    'should allow calls on expressions': {
        input: '<div>{{(content() || bar)(foo)}}</div>'
    },
    'should allow boolean attribute values': {
        input: '<tag on=true off=false/>'
    },
    'should parse typed views': {
        input: '{% view Main (Context[String]) %} <p>{{@value}}</p>'
    },
    'should parse typed views with type classes': {
        input: '{% view Main [A,B] (Context[A,B]) %} <p>{{@values}}</p>'
    },
    'should parse context variables': {
        input: '<Input name={{@level.name}}/>'
    },
    'should allow construct expression': {
        input: '<TextView android:thing={value:1}>{{Person(@value)}}</TextView>'
    },
    'should allow view construction': {
        input: '<p>{{ <Panel(@)> }}</p>'
    },
    'should allow fun application': {
        input: '<p>{{ <panel(1)(2)(3)> }}</p>'
    },
    'should allow fun application with context': {
        input: '<div>{{ <panel(@)(12)> }}</div>'
    },
    'should allow fun statements to specify a context (part 2)': {
        input: "{% fun action (_:Date) (n:String) %} <p>{{n}}</p> {% endfun %}"
    },
    'should parse list types': {
        input: '{% fun action [A] (s: String[]) (a:A[]) = {{  \'${s}${a}\' }} %}'
    },
    'should allow context properties as fun application': {
        input: '<div>{{ <@action()> }}</div>'
    },
    'should allow view statements after short fun': {
        input: "\n\n{% fun template [A] (d: Date[A]) (o:A) (_:String) (__:A[]) = {{String(o)}}  %}\n\n{% view Results [A](Date[A]) %}\n\n  <ul>\n\n    {% for option,index in [1,3,4] %}\n\n      <li>{{option}}and{{index}}</li>\n\n    {% else %}\n\n      <p>De nada!</p>\n\n    {% endfor %}\n\n  </ul>"
    },
    'should allow actual code': {
        input: "\n\t{% import (Table) from \"@quenk/wml-widgets/lib/data/table\" %}\n        {% import (TextField) from \"@quenk/wml-widgets/lib/control/text-field\" %}\n        {% import (Panel) from \"@quenk/wml-widgets/lib/layout/panel\" %}\n        {% import (PanelHeader) from \"@quenk/wml-widgets/lib/layout/panel\" %}\n        {% import (Tab) from \"@quenk/wml-widgets/lib/control/tab-bar\" %}        \n\t{% import (TabBar) from \"@quenk/wml-widgets/lib/control/tab-bar\" %}\n        {% import (TabSpec) from \"..\" %}\n        {% import (TabbedPanel) from \"..\" %}\n\n\t{% view Main (TabbedPanel) %}\n\n\t  <Panel ww:class={{@values.root.class}}>\n\n           {% if (@values.header.tabs.length > 0) || (@values.header.additionalTabs) %}\n\n             <PanelHeader>\n\n               <TabBar>\n\n                {% for tab in @values.header.tabs %}\n\n                  <Tab \n                   ww:name={{tab.name}}\n                   ww:onClick={{tab.onClick}} />\n\n                {% endfor %}\n\n                {% if @values.header.additionalTabs %}\n\n                  {{<(@values.header.additionalTabs)(@)>}}\n\n               {% else %}\n\n              \t{{''}}\n\n               {% endif %}\n\n             </TabBar>\n\n           </PanelHeader>\n\n         {% else %}\n\n          {{''}}\n\n        {% endif %}\n\n        {{@children}}\n\n</Panel>"
    }
};
//# sourceMappingURL=test.js.map