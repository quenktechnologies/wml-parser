
import * as ___wml from '../../src';




export class Main extends ___wml.AppView<void> {

    constructor(___context: void) {

        super(___context);

        this.template = (___view:___wml.AppView<void>) =>
          ___wml.node('modal', {html : { 'name' : `mymodal` ,'x' : `1` ,'y' : `2`  } ,wml : {  } }, [___wml.node('modal-header', {html : {  } ,wml : {  } }, [___wml.text(`My Modal`)], ___view) ,___wml.node('modal-body', {html : {  } ,wml : {  } }, [___wml.text(`Creativxity is inhibxited by greed and corruption.`),___wml.node('vote-button', {html : {  } ,wml : {  } }, [], ___view) ,___wml.node('vote-count', {html : { 'source' : ___context  } ,wml : {  } }, [], ___view) ,___wml.text(` Votes`),___wml.node('textarea', {html : { 'disabled' : true  ,'size' : 32 ,'onchange' : ___context.setText  } ,wml : { 'id' : `ta`  } }, [___wml.text(` Various text`)], ___view) ], ___view) ], ___view) ;

       }

     }

