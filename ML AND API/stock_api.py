# Dependencies
from flask import Flask, request, jsonify
import joblib
import traceback
import pandas as pd
import numpy as np
from alpha_vantage.timeseries import TimeSeries

# Your API definition
app = Flask(__name__)

@app.route('/predict/<string:n>')
def predict(n):
    if lr:
        try:
            API_key='EG7F71P0XMBDB6YM'
            ts=TimeSeries(key=API_key,output_format='pandas')
            data=ts.get_daily_adjusted(n,outputsize='full')
            df=data[0]
            df=df.reset_index()
            df=df.drop(['date'],axis=1)
            df=df.drop(['5. adjusted close'],axis=1)
            df=df.drop(['7. dividend amount'],axis=1)
            df=df.drop(['8. split coefficient'],axis=1)
            df.set_axis(['open', 'high', 'low','close','volume'], axis='columns', inplace=True)
            
            train=pd.DataFrame(df['close'][0:int(len(df)*0.70)])
            test=pd.DataFrame(df['close'][int(len(df)*0.70):int(len(df))])
    
            past_100_days=train.head(100)
            final_df=past_100_days.append(test,ignore_index=True)
            
            input_data=final_df.to_numpy()
            
            x_test=[]
            y_test=[]
            for i in range(100,input_data.shape[0]):
                x_test.append(input_data[i-100:i])
                y_test.append(input_data[i,0])
            x_test,y_test=np.array(x_test),np.array(y_test)
            
            #y_predict=model.predict(x_test)

            prediction = lr.predict(x_test)

            return jsonify({'prediction': str(prediction[1][0])})

        except:

            return jsonify({'trace': traceback.format_exc()})
    else:
        print ('Train the model first')
        return ('No model here to use')

if __name__ == '__main__':
    try:
        port = int(sys.argv[1]) # This is for a command-line input
    except:
        port = 12345 # If you don't provide any port the port will be set to 12345

    lr = joblib.load("model.pkl") # Load "model.pkl"
    print ('Model loaded')
    app.run(port=port, debug=True)