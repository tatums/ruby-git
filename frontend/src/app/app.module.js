import { NgModule } from '@angular/core'
import { HttpModule } from '@angular/http';
import { RouterModule, Routes } from '@angular/router'
import { FormsModule }   from '@angular/forms';
import { BrowserModule } from '@angular/platform-browser'

import { AppComponent } from './app.component'
import { HomeComponent } from './home'
import { EditComponent } from './edit'
import { IdResolver } from './resolvers/id-resolver'

const appRoutes = [
  {
    path: '',
    component: HomeComponent,
  },
  {
    path: 'edit/:id',
    component: EditComponent,
    resolve: {
      id: IdResolver
    }
  },
]

@NgModule({
  imports: [
    BrowserModule,
    FormsModule,
    HttpModule,
    RouterModule.forRoot(appRoutes)
  ],
  declarations: [
    AppComponent,
    HomeComponent,
    EditComponent
  ],
  providers: [ IdResolver ],
  bootstrap: [ AppComponent ]
})

export class AppModule { }
