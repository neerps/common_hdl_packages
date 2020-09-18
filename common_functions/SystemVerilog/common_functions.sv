//====================================================================================
/*

Target language SystemVerilog

Package that contains functions which can be useful for any design

*/
//====================================================================================
/* Copyright 2020 Igor Fomin

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License. */
//====================================================================================
package common_functions;
//------------------------------------------------------------------------------------
function logic set_sig_lvl (
    string p_lvl_to_set
);

    logic l_vec_to_out;

    assert ((p_lvl_to_set == "HIGH") || (p_lvl_to_set == "LOW")) 
    else $error("Passed a wrong parameter. Should be 'High' or 'Low'");

    if (p_lvl_to_set == "HIGH")

        l_vec_to_out = 1'b1;
        return l_vec_to_out;

    else if (p_lvl_to_set == "LOW")

        l_vec_to_out = 1'b0;
        return l_vec_to_out;

    else

        l_vec_to_out = 1'b0
        return l_vec_to_out;

endfunction
//------------------------------------------------------------------------------------
endpackage;