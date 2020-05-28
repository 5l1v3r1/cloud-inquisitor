package resource

import (
	"encoding/json"

	openapis3 "github.com/RiotGames/cloud-inquisitor/cinq_resources/aws_s3_openapi"
)

type AWSS3Storage struct {
	State        int
	AccountID    string
	Region       string
	ResourceArn  string
	ResourceID   string
	ResourceType string

	Tags map[string]string
}

func (s3 *AWSS3Storage) New(event interface{}) {
	eventBytes, err := json.Marshal(event)
	if err != nil {
		return nil, err
	}

	var s3OpenAPI openapis3.AwsEvent
	err = json.Unmarshal(eventBytes, &s3OpenAPI)
	if err != nil {
		return nil, err
	}

	returnS3Resource := &AWSS3Storage{
		State: 0,
		AccountID: s3OpenAPI.Account,
		Region: s3OpenAPI.Region,
		ResourceType: 
	}
}
