##########################################
# Student B: Complete the following code #
##########################################
# Load the dataset from your Google Cloud Storage bucket.
Xy_train = pd.read_csv('gs://agp-workshop-bucket-2025/data/digits_train.csv')

# Instantiate classifier.
classifier = LogisticRegressionCV(max_iter=1000)
##########################################

y_train = Xy_train.pop('label')
X_train = Xy_train
classifier.fit(X_train, y_train)

joblib.dump(classifier, 'model.joblib')

# Upload model artifact to Google Cloud Storage bucket.
model_directory = os.environ['AIP_MODEL_DIR']
storage_path = os.path.join(model_directory, 'model.joblib')
blob = storage.blob.Blob.from_string(storage_path, client=storage.Client())
blob.upload_from_filename('model.joblib')
