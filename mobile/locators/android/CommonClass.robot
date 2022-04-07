Documentation     This file consist common class variable for Android.
           ...    - User can use this variable to create locator.
           ...    - Example:
           ...            ${xPathPrefix}${textViewClass}[@text='Text to be varified']

*** Settings ***
Resource    ${SettingsPageElem}.robot
Resource    ${AndroidCls}.robot
Resource    ${labels}.robot

*** Variables ***

###################    COMMON VARIABLE    #######################
${xPathPrefix}                          //

###################    COMMON WIDGET CLASS    ###################
${progressBarClass}                     android.widget.ProgressBar
${textViewClass}                        android.widget.TextView
${imageButtonClass}                     android.widget.ImageButton
${calendarViewClass}                    android.widget.CalendarView
${checkedTextViewClass}                 android.widget.CheckedTextView
${compoundButtonClass}                  android.widget.CompoundButton
${expandableListViewClass}              android.widget.ExpandableListView
${listPopupWindowClass}                 android.widget.ListPopupWindow
${popupMenuClass}	                    android.widget.PopupMenu
${popupWindowClass}                     android.widget.PopupWindow
${filterClass}                          android.widget.Filter
${numberPickerClass}                    android.widget.NumberPicker
${filterResultsClass}                   android.widget.Filter.FilterResults
${gridLayoutClass}                      android.widget.GridLayout
${gridViewClass}                        android.widget.GridView
${relativeLayoutClass}                  android.widget.RelativeLayout
${linearLayoutClass}                    android.widget.LinearLayout
${switchClass}                          android.widget.Switch
${toolBarClass}                         android.widget.Toolbar
${videoViewClass}                       android.widget.VideoView
${viewAnimatorClass}                    android.widget.ViewAnimator
${viewSwitcherClass}                    android.widget.ViewSwitcher
${scrollViewClass}                      android.widget.ScrollView
${scrollerClass}                        android.widget.Scroller
${searchViewClass}                      android.widget.SearchView
${spinnerClass}	                        android.widget.Spinner
${buttonClass}                          android.widget.Button
${editTextClass}                        android.widget.EditText
${imageViewClass}                       android.widget.ImageView
${frameLayoutClass}                     android.widget.FrameLayout
${checkBoxClass}                        android.widget.CheckBox
${listViewClass}                        android.widget.ListView
${radioGroupClass}                      android.widget.RadioGroup
${ratingBarClass}                       android.widget.RatingBar
${radioButtonClass}                     android.widget.RadioButton
${layout}				TextInputLayout
${viewClass}				android.view.View
${MultiAutoCompleteTextView}		android.widget.MultiAutoCompleteTextView
${tabHost}				android.widget.TabHost
${seekbar}				android.widget.SeekBar
${toggleButtonClass}                    android.widget.ToggleButton
${textInputLayout}                      TextInputLayout

###################    COMMON WEBKIT CLASS    ###################
${webViewClass}                         android.webkit.WebView
