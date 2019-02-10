
import * as ___wml from '../../src';




export class Main extends ___wml.AppView<void> {

    constructor(___context: void) {

        super(___context);

        this.template = (___view:___wml.AppView<void>) =>
          ___wml.widget(Tag, {html : {  } ,wml : {  } }, [(value)? ___wml.node('text', {html : {  } ,wml : {  } }, [___wml.text(`Text`)], ___view) :(value)? ___wml.node('text', {html : {  } ,wml : {  } }, [___wml.text(`else`)], ___view) :___wml.text(` 
            no 
          `)], ___view);

       }

     }

