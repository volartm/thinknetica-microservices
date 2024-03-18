to create ad from cli use
http -f post :5000/ads/v1 "ad[title]=Title" "ad[description]=Dsdada" "ad[city]=City" "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1dWlkIjoiNzZiNDVjODMtMTgxMy00M2QxLWE5M2UtZmI5OWUwNjJmNDQ2In0.Y5FEfv04HhcS9hlN2q3LMIP-tM3prl1iHN651TjrpnQ"
to create from postman use the same params like 'ad[city'] if form-data tab
to get list - http :5000/ads/v1