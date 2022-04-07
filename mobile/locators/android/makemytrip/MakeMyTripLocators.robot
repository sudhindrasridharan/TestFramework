Documentation     This robot file consist of different locators of MakeMyTrip android application.

*** Settings ***
Resource        ../CommonClass.robot

*** Variables ***
${parent}                       com.makemytrip:id
${wifiButton}                   ${xPathPrefix}${switchClass}
${locationButton}               ${xPathPrefix}${switchClass}
${alertBox}                     ${xPathPrefix}${textViewClass}[@resource-id='android:id/alertTitle']

###################    LOGIN PAGE    ###################
${loginPage}                    ${xPathPrefix}${linearLayoutClass}[@resource-id='${parent}/action_bar_root']
${skipButton}                   ${xPathPrefix}${textViewClass}[@resource-id='${parent}/skip_onboarding']

###################    HOME PAGE    ###################
${runTimeAdd}                   ${xPathPrefix}${relativeLayoutClass}[@index=1]
${tripsButton}                  ${xPathPrefix}${textViewClass}[@resource-id='${parent}/bb_mytrips']
${networkError}                 ${xPathPrefix}${relativeLayoutClass}[@index=0]/${textViewClass}[@resource-id='${parent}/noConn']
${tryAgainButton}               ${xPathPrefix}${relativeLayoutClass}[@index=0]/${textViewClass}[@resource-id='${parent}/tryAgain']
${helpButton}                   ${xPathPrefix}${textViewClass}[@resource-id='${parent}/bb_help']
${myButton}                     ${xPathPrefix}${imageViewClass}[@resource-id='${parent}/my_icon']
${flightButton}                 ${xPathPrefix}${relativeLayoutClass}[@resource-id='${parent}/rlIconLayout' and @index='0']
${holidayButton}                ${xPathPrefix}${relativeLayoutClass}[@resource-id='${parent}/rlIconLayout' and @index='2']
${trainButton}                  ${xPathPrefix}${relativeLayoutClass}[@resource-id='${parent}/rlIconLayout' and @index='3']

###################    TRIPS PAGE    ###################
${tripPage}                     ${xPathPrefix}${relativeLayoutClass}[@resource-id='${parent}/rlv_lyt_login_option']
${emailEditText}                ${xPathPrefix}${editTextClass}[@resource-id='${parent}/edt_txt_signin_email']
${passwordEditText}             ${xPathPrefix}${editTextClass}[@resource-id='${parent}/edt_txt_signin_password']
${loginButton}                  ${xPathPrefix}${buttonClass}[@resource-id='${parent}/btn_signin']
${referralCode}                 ${xPathPrefix}${textViewClass}[@resource-id='${parent}/txt_vw_referral_code']
${referralCodePage}             ${xPathPrefix}${textViewClass}[@resource-id='${parent}/heading_referral_code']
${referralEdit}                 ${xPathPrefix}${editTextClass}[@resource-id='${parent}/edt_txt_referrer_code']
${referralApply}                ${xPathPrefix}${buttonClass}[@resource-id='${parent}/btn_apply_promo_code']
${referralCodeError}            ${xPathPrefix}${textViewClass}[@resource-id='${parent}/txt_vw_invalid_referral_code']

###################    HELP PAGE    ###################
${helpHeader}                   ${xPathPrefix}${relativeLayoutClass}[@resource-id='${parent}/header']/${textViewClass}[@resource-id='${parent}/topbarheader']
${searchEditText}               ${xPathPrefix}${editTextClass}[@resource-id='${parent}/faq_search_bar']
${searchQueryText}              ${xPathPrefix}${textViewClass}[@resource-id='${parent}/faq_search_query_txt']
${searchQueryAns}               ${xPathPrefix}${relativeLayoutClass}[@resource-id='${parent}/faq_answer_card']

###################    MY VIEW PAGE    ###################
${shortList}                    ${xPathPrefix}${imageViewClass}[@resource-id='${parent}/ivItemIcon' and @index='1']
${notification}                 ${xPathPrefix}${imageViewClass}[@resource-id='${parent}/ivItemIcon' and @index='1']
${profile}                      ${xPathPrefix}${imageViewClass}[@resource-id='${parent}/ivItemIcon' and @index='1']
${contacts}                     ${xPathPrefix}${imageViewClass}[@resource-id='${parent}/ivItemIcon' and @index='1']
${coupon}                       ${xPathPrefix}${imageViewClass}[@resource-id='${parent}/ivItemIcon' and @index='1']
${shortListScreen}              ${xPathPrefix}${textViewClass}[@resource-id='${parent}/title']
${noShortListText}              ${xPathPrefix}${textViewClass}[@resource-id='${parent}/no_shortlist_text']

###################    FLIGHT PAGE    ###################
${flightPage}                   ${xPathPrefix}${textViewClass}[@text='Flight Search']
${enterCityName}                ${xPathPrefix}${editTextClass}[@text='Enter City/Airport Name']
${selectAmd}                    ${xPathPrefix}${viewClass}[@index='0']/${textViewClass}[@text='Ahmedabad, India']
${travellersPage}               ${xPathPrefix}${textViewClass}[@text='Select Travellers & Class']
${adults}                       ${xPathPrefix}${viewClass}[@index='3']/${viewClass}[@index='2']/${textViewClass}[@index='0']
${verifyAdultsNum}              ${xPathPrefix}${viewClass}[@index='3']/${textViewClass}[@index='1']
${filterButton}                 ${xPathPrefix}${linearLayoutClass}[@resource-id='${parent}/sortAndFilter']
${applyButton}                  ${xPathPrefix}${buttonClass}[@resource-id='${parent}/apply_button']
${filterPath}                   ${xPathPrefix}${relativeLayoutClass}[@resource-id='${parent}/filter_airline']/${textViewClass}[@text='IndiGo']
${indigoFilter}                 ${xPathPrefix}${textViewClass}[@text='IndiGo' and @resource-id='${parent}/df_flight_airline_name']

###################    HOLIDAY PAGE    ###################
${holidayPage}                  ${xPathPrefix}${textViewClass}[@resource-id='${parent}/tvSearchDestLabel']
${holidayImg}                   ${xPathPrefix}${relativeLayoutClass}[@resource-id='${parent}/rlHolidayLandingPrimaryBottom']

###################  CAB PAGE    ########################
${cabPage}                      ${xPathPrefix}${textViewClass}[@text='Cabs']
${currentLocationText}          ${xPathPrefix}${textViewClass}[@text='USE CURRENT LOCATION']
${goAheadText}                  ${xPathPrefix}${textViewClass}[@text='GO AHEAD']
${allowButton}                  ${xPathPrefix}${buttonClass}[@text='ALLOW']
${okButton}                     ${xPathPrefix}${buttonClass}[@text='OK']
${dropAdress}                   ${xPathPrefix}${editTextClass}[@text='Enter drop address/nearby area']
${destLocation}                 ${xPathPrefix}${textViewClass}[@text='Bopal']
${searchButton}                 ${xPathPrefix}${textViewClass}[@text='SEARCH']
${gotTtButton}                  ${xPathPrefix}${textViewClass}[@text='GOT IT']
${pickUpDate}                   ${xPathPrefix}${textViewClass}[@text='PICK-UP DATE']
${pickUpTime}                   ${xPathPrefix}${textViewClass}[@text='PICK-UP TIME']
